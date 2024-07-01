// pokemon_view_model.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex/model/pokemon_evolution_model.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/model/pokemon_moves_model.dart';

class PokemonViewModel extends ChangeNotifier {
  List<Pokemon> _pokemons = [];
  bool _isLoading = false;
  String? _nextUrl = 'https://pokeapi.co/api/v2/pokemon?limit=50';

  List<Pokemon> get pokemons => _pokemons;
  bool get isLoading => _isLoading;

  PokemonViewModel() {
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    if (_isLoading || _nextUrl == null) return;

    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(_nextUrl!));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      _nextUrl = jsonResponse['next'];

      final List<dynamic> results = jsonResponse['results'];
      List<Pokemon> newPokemons = await Future.wait(results.map((data) async {
        final pokemonDetailsResponse = await http.get(Uri.parse(data['url']));
        final pokemonDetailsJson = json.decode(pokemonDetailsResponse.body);

        // Fetch additional details such as description, gender, egg groups, egg cycle
        final speciesUrl = pokemonDetailsJson['species']['url'];
        final speciesResponse = await http.get(Uri.parse(speciesUrl));
        final speciesJson = json.decode(speciesResponse.body);

        // Fetch evolution chain
        final evolutionChainUrl = speciesJson['evolution_chain']['url'];
        final evolutionChainResponse =
            await http.get(Uri.parse(evolutionChainUrl));
        final evolutionChainJson = json.decode(evolutionChainResponse.body);

        List<Evolution> evolutions =
            parseEvolutionChain(evolutionChainJson['chain']);

        return Pokemon.fromJson({
          'name': data['name'],
          'url': data['url'],
          'types': pokemonDetailsJson['types'],
          'sprites': pokemonDetailsJson['sprites'],
          'height': pokemonDetailsJson['height'],
          'weight': pokemonDetailsJson['weight'],
          'stats': pokemonDetailsJson['stats'],
          'moves': pokemonDetailsJson['moves'],
          'description': speciesJson['flavor_text_entries'][0]['flavor_text']
              .replaceAll('\n', ''),
          'gender': getGenderRate(speciesJson['gender_rate']),
          'egg_groups': speciesJson['egg_groups'],
          'egg_cycle': speciesJson['hatch_counter'].toString(),
        }, evolutions);
      }).toList());

      _pokemons.addAll(newPokemons);
    } else {
      throw Exception('Failed to load pokemons');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoveDetails(Pokemon pokemon) async {
    List<MoveDetail> moveDetails =
        await Future.wait(pokemon.moves.map((moveName) async {
      final response = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/move/$moveName/'));
      if (response.statusCode == 200) {
        final moveJson = json.decode(response.body);
        return MoveDetail.fromJson(moveJson);
      } else {
        throw Exception('Failed to load move details');
      }
    }).toList());

    // Actualizar el Pokemon con los detalles de los movimientos
    pokemon.moveDetails.addAll(moveDetails);
    notifyListeners();
  }

  List<Evolution> parseEvolutionChain(Map<String, dynamic> chain) {
    List<Evolution> evolutions = [];

    Evolution currentEvolution = Evolution(
      name: chain['species']['name'],
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${getPokemonIdFromUrl(chain['species']['url'])}.png',
    );

    evolutions.add(currentEvolution);

    while (chain['evolves_to'] != null && chain['evolves_to'].isNotEmpty) {
      chain = chain['evolves_to'][0];
      currentEvolution = Evolution(
        name: chain['species']['name'],
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${getPokemonIdFromUrl(chain['species']['url'])}.png',
      );
      evolutions.add(currentEvolution);
    }

    return evolutions;
  }

  int getPokemonIdFromUrl(String url) {
    final uri = Uri.parse(url);
    final segments = uri.pathSegments;
    return int.parse(segments[segments.length - 2]);
  }

  String getGenderRate(int rate) {
    if (rate == -1) return 'Genderless';
    final maleRate = (8 - rate) * 12.5;
    final femaleRate = rate * 12.5;
    return 'Male: ${maleRate}%, Female: ${femaleRate}%';
  }
}

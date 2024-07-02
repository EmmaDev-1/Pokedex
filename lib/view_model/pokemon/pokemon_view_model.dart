import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex/model/pokemon/pokemon_evolution_model.dart';
import 'package:pokedex/model/pokemon/pokemon_model.dart';
import 'package:pokedex/model/pokemon/pokemon_moves_model.dart';
import 'package:pokedex/utils/end_Points/end_point.dart';
import 'package:pokedex/view_model/pokemon/evolution_view_model.dart';

class PokemonViewModel extends ChangeNotifier {
  final List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];
  bool _isLoading = false;

  List<Pokemon> get pokemons => _pokemons;
  List<Pokemon> get filteredPokemons => _filteredPokemons;
  bool get isLoading => _isLoading;

  PokemonViewModel() {
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(pokedexApi));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        pokedexApi = jsonResponse['next'];

        final List<dynamic> results = jsonResponse['results'];
        List<Pokemon> newPokemons = await compute(fetchPokemonDetails, results);

        _pokemons.addAll(newPokemons);
        _filteredPokemons = List.from(
            _pokemons); // Inicialmente, todos los Pokémon son mostrados
      } else {
        throw Exception('Failed to load pokemons');
      }
    } catch (e) {
      // Manejar error
      print("Error fetching pokemons: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoveDetails(Pokemon pokemon) async {
    List<MoveDetail> moveDetails =
        await Future.wait(pokemon.moves.map((moveName) async {
      final response = await http.get(Uri.parse('$pokemonMoves$moveName/'));
      if (response.statusCode == 200) {
        final moveJson = json.decode(response.body);
        return MoveDetail.fromJson(moveJson);
      } else {
        throw Exception('Failed to load move details');
      }
    }).toList());

    pokemon.moveDetails.addAll(moveDetails);
    notifyListeners();
  }

  String getGenderRate(int rate) {
    if (rate == -1) return 'Genderless';
    final maleRate = (8 - rate) * 12.5;
    final femaleRate = rate * 12.5;
    return 'Male: ${maleRate}%, Female: ${femaleRate}%';
  }

  void searchPokemon(String query) {
    if (query.isEmpty) {
      _filteredPokemons = List.from(_pokemons);
    } else {
      _filteredPokemons = _pokemons
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

Future<List<Pokemon>> fetchPokemonDetails(List<dynamic> results) async {
  return await Future.wait(results.map((data) async {
    final pokemonDetailsResponse = await http.get(Uri.parse(data['url']));
    final pokemonDetailsJson = json.decode(pokemonDetailsResponse.body);

    final speciesUrl = pokemonDetailsJson['species']['url'];
    final speciesResponse = await http.get(Uri.parse(speciesUrl));
    final speciesJson = json.decode(speciesResponse.body);

    final evolutionChainUrl = speciesJson['evolution_chain']['url'];
    final evolutionChainResponse = await http.get(Uri.parse(evolutionChainUrl));
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
}

String getGenderRate(int rate) {
  if (rate == -1) return 'Genderless';
  final maleRate = (8 - rate) * 12.5;
  final femaleRate = rate * 12.5;
  return 'Male: ${maleRate}%, Female: ${femaleRate}%';
}

// view_model/pokemon_view_model.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex/model/pokemon_model.dart';

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
        return Pokemon.fromJson({
          'name': data['name'],
          'url': data['url'],
          'types': pokemonDetailsJson['types'],
          'sprites': pokemonDetailsJson['sprites'],
          'height': pokemonDetailsJson['height'],
          'weight': pokemonDetailsJson['weight'],
          'stats': pokemonDetailsJson['stats'],
          'moves': pokemonDetailsJson['moves'],
          // Fetch evolution details if needed
        });
      }).toList());

      _pokemons.addAll(newPokemons);
    } else {
      throw Exception('Failed to load pokemons');
    }

    _isLoading = false;
    notifyListeners();
  }
}

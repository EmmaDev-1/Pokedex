// view_model/pokemon_view_model.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/utils/end_points/end_point.dart';

class PokemonViewModel extends ChangeNotifier {
  List<Pokemon> _pokemons = [];
  bool _isLoading = true;

  List<Pokemon> get pokemons => _pokemons;
  bool get isLoading => _isLoading;

  PokemonViewModel() {
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    final response = await http.get(Uri.parse(pokedexApi));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> results = jsonResponse['results'];
      _pokemons = await Future.wait(results.map((data) async {
        final pokemonDetailsResponse = await http.get(Uri.parse(data['url']));
        final pokemonDetailsJson = json.decode(pokemonDetailsResponse.body);
        return Pokemon.fromJson({
          'name': data['name'],
          'url': data['url'],
          'types': pokemonDetailsJson['types'],
          'sprites': pokemonDetailsJson['sprites'],
          'height': pokemonDetailsJson['height'],
          'weight': pokemonDetailsJson['weight'],
        });
      }).toList());
      _isLoading = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load pokemons');
    }
  }
}

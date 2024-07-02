import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex/model/pokemon/pokemon_model.dart';

class SpeciesViewModel extends ChangeNotifier {
  List<Pokemon> _regionPokemons = [];
  bool _isLoading = false;

  List<Pokemon> get regionPokemons => _regionPokemons;
  bool get isLoading => _isLoading;

  Future<void> fetchRegionPokemons(List<String> pokemonSpecies) async {
    _isLoading = true;
    notifyListeners();

    _regionPokemons = [];

    try {
      for (String species in pokemonSpecies) {
        if (species.isNotEmpty) {
          final response = await http.get(Uri.parse('$pokemonSpecies$species'));

          if (response.statusCode == 200) {
            var data = json.decode(response.body);
            var pokemon = Pokemon.fromJson(data, []);
            _regionPokemons.add(pokemon);
          } else {}
        } else {}
      }
    } catch (error) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

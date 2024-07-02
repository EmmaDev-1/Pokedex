import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/region/generation_model.dart';
import 'package:pokedex/model/region/location_model.dart';
import 'package:pokedex/model/region/region_model.dart';
import 'dart:convert';

import 'package:pokedex/utils/end_Points/end_point.dart';

class RegionViewModel extends ChangeNotifier {
  List<Region> _regions = [];
  List<Location> _locations = [];
  Generation? _generation;
  bool _isLoading = false;

  List<Region> get regions => _regions;
  List<Location> get locations => _locations;
  Generation? get generation => _generation;
  bool get isLoading => _isLoading;

  RegionViewModel() {
    fetchRegions();
  }

  Future<void> fetchRegions() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(pokemonRegion));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['results'];
        _regions = data.map((region) => Region.fromJson(region)).toList();
      } else {
        throw Exception('Failed to load regions');
      }
    } catch (error) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLocationsForRegion(String regionUrl) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(regionUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> locationsData = data['locations'];
        _locations = locationsData
            .map((location) => Location.fromJson(location))
            .toList();
        if (data['main_generation'] != null) {
          final generationUrl = data['main_generation']['url'];
          await fetchGeneration(generationUrl);
        } else {
          _generation = null;
        }
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (error) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchGeneration(String generationUrl) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(generationUrl));

      if (response.statusCode == 200) {
        _generation = Generation.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load generation');
      }
    } catch (error) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:pokedex/model/location/location_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationViewModel extends ChangeNotifier {
  List<Location> _locations = [];
  bool _isLoading = false;

  List<Location> get locations => _locations;
  bool get isLoading => _isLoading;

  LocationViewModel() {
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    _isLoading = true;
    notifyListeners();

    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/location'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      _locations = data.map((location) => Location.fromJson(location)).toList();
    }

    _isLoading = false;
    notifyListeners();
  }
}

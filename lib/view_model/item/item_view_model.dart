import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pokedex/model/item/item_model.dart';
import 'package:pokedex/model/item/category_model.dart';
import 'package:pokedex/utils/end_Points/end_point.dart';

class ItemViewModel extends ChangeNotifier {
  List<Item> _items = [];
  Category? _category;
  bool _isLoading = false;
  String? _nextUrl;

  List<Item> get items => _items;
  Category? get category => _category;
  bool get isLoading => _isLoading;

  ItemViewModel() {
    fetchItems();
  }

  Future<void> fetchItems({String? url}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(url ?? pokemonItem));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['results'];
        _nextUrl = jsonResponse['next'];

        List<Item> newItems = await Future.wait(data.map((item) async {
          final itemResponse = await http.get(Uri.parse(item['url']));
          return Item.fromJson(json.decode(itemResponse.body));
        }).toList());

        _items.addAll(newItems);
      } else {
        throw Exception('Failed to load items');
      }
    } catch (error) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextItems() async {
    if (_nextUrl != null) {
      await fetchItems(url: _nextUrl);
    }
  }

  Future<void> fetchCategory(String categoryUrl) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(categoryUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _category = Category.fromJson(data);

        List<dynamic> itemUrls = data['items'];
        _category!.items
            .addAll(await Future.wait(itemUrls.map((itemData) async {
          final itemResponse = await http.get(Uri.parse(itemData['url']));
          return Item.fromJson(json.decode(itemResponse.body));
        }).toList()));
      } else {
        throw Exception('Failed to load category');
      }
    } catch (error) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

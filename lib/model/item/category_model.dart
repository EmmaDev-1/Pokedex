import 'item_model.dart';

class Category {
  final String name;
  final List<Item> items;

  Category({
    required this.name,
    required this.items,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      items: [],
    );
  }
}

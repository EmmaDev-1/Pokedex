class Item {
  final String name;
  final String url;
  final String imageUrl;
  final String category;
  final String categoryUrl;
  final String effect;

  Item({
    required this.name,
    required this.url,
    required this.imageUrl,
    required this.category,
    required this.categoryUrl,
    required this.effect,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    String cleanedEffect =
        (json['effect_entries'] != null && json['effect_entries'].isNotEmpty)
            ? json['effect_entries'][0]['effect']
                .replaceAll('\n', ' ')
                .replaceAll(RegExp(r'\s+'), ' ')
                .trim()
            : 'No effect';

    return Item(
      name: json['name'] ?? 'Unknown',
      url: json['url'] ?? '',
      imageUrl: json['sprites'] != null && json['sprites']['default'] != null
          ? (json['sprites']['other'] != null &&
                  json['sprites']['other']['official-artwork'] != null
              ? json['sprites']['other']['official-artwork']['front_default']
              : json['sprites']['default'])
          : '',
      category: json['category'] != null ? json['category']['name'] : 'Unknown',
      categoryUrl: json['category'] != null ? json['category']['url'] : '',
      effect: cleanedEffect,
    );
  }
}

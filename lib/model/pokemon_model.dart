// model/pokemon.dart
class Pokemon {
  final String name;
  final String url;
  final List<String> types;
  final String imageUrl;
  final int height;
  final int weight;

  Pokemon({
    required this.name,
    required this.url,
    required this.types,
    required this.imageUrl,
    required this.height,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
      types:
          List<String>.from(json['types'].map((type) => type['type']['name'])),
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}

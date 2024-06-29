class Pokemon {
  final String name;
  final String url;
  final List<String> types;
  final String imageUrl;
  final int height;
  final int weight;
  final List<Stat> stats;
  final List<Evolution> evolutions;
  final List<String> moves;

  Pokemon({
    required this.name,
    required this.url,
    required this.types,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.stats,
    required this.evolutions,
    required this.moves,
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
      stats: List<Stat>.from(json['stats'].map((stat) => Stat.fromJson(stat))),
      evolutions: [], // Implement evolution details fetching
      moves:
          List<String>.from(json['moves'].map((move) => move['move']['name'])),
    );
  }
}

class Stat {
  final String name;
  final int value;

  Stat({required this.name, required this.value});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      name: json['stat']['name'],
      value: json['base_stat'],
    );
  }
}

class Evolution {
  final String name;
  final String imageUrl;

  Evolution({required this.name, required this.imageUrl});

  factory Evolution.fromJson(Map<String, dynamic> json) {
    return Evolution(
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
    );
  }
}

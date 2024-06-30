import 'package:pokedex/model/pokemon_evolution_model.dart';
import 'package:pokedex/model/pokemon_stats_model.dart';

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
  final String description; // Nueva propiedad
  final String gender; // Nueva propiedad
  final List<String> eggGroups; // Nueva propiedad
  final String eggCycle; // Nueva propiedad

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
    required this.description, // Nuevo parámetro
    required this.gender, // Nuevo parámetro
    required this.eggGroups, // Nuevo parámetro
    required this.eggCycle, // Nuevo parámetro
  });

  factory Pokemon.fromJson(
      Map<String, dynamic> json, List<Evolution> evolutions) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
      types:
          List<String>.from(json['types'].map((type) => type['type']['name'])),
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      height: json['height'],
      weight: json['weight'],
      stats: List<Stat>.from(json['stats'].map((stat) => Stat.fromJson(stat))),
      evolutions: evolutions, // Utiliza los datos de evoluciones
      moves:
          List<String>.from(json['moves'].map((move) => move['move']['name'])),
      description:
          json['description'], // Asume que obtienes este dato de algún lado
      gender: json['gender'], // Asume que obtienes este dato de algún lado
      eggGroups: List<String>.from(json['egg_groups'].map((group) =>
          group['name'])), // Asume que obtienes este dato de algún lado
      eggCycle: json['egg_cycle'], // Asume que obtienes este dato de algún lado
    );
  }
}

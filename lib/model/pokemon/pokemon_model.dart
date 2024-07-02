import 'package:pokedex/model/pokemon/pokemon_evolution_model.dart';
import 'package:pokedex/model/pokemon/pokemon_moves_model.dart';
import 'package:pokedex/model/pokemon/pokemon_stats_model.dart';

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
  final List<MoveDetail> moveDetails;
  final String description;
  final String gender;
  final List<String> eggGroups;
  final String eggCycle;

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
    required this.moveDetails,
    required this.description,
    required this.gender,
    required this.eggGroups,
    required this.eggCycle,
  });

  factory Pokemon.fromJson(
      Map<String, dynamic> json, List<Evolution> evolutions) {
    return Pokemon(
      name: json['name'] ?? 'Unknown',
      url: json['url'] ?? '',
      types: (json['types'] as List<dynamic>?)
              ?.map((type) => type['type']['name'] as String)
              .toList() ??
          [],
      imageUrl:
          json['sprites']['other']['official-artwork']['front_default'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      stats: (json['stats'] as List<dynamic>?)
              ?.map((stat) => Stat.fromJson(stat))
              .toList() ??
          [],
      evolutions: evolutions,
      moves: (json['moves'] as List<dynamic>?)
              ?.map((move) => move['move']['name'] as String)
              .toList() ??
          [],
      moveDetails: [],
      description: json['description'] ?? 'No description available',
      gender: json['gender'] ?? 'Unknown',
      eggGroups: (json['egg_groups'] as List<dynamic>?)
              ?.map((group) => group['name'] as String)
              .toList() ??
          [],
      eggCycle: json['egg_cycle'] ?? 'Unknown',
    );
  }
}

class Generation {
  final List<String> pokemonSpecies;
  final List<String> types;

  Generation({
    required this.pokemonSpecies,
    required this.types,
  });

  factory Generation.fromJson(Map<String, dynamic> json) {
    return Generation(
      pokemonSpecies: (json['pokemon_species'] as List<dynamic>)
          .map((species) => species['name'] as String)
          .toList(),
      types: (json['types'] as List<dynamic>)
          .map((type) => type['name'] as String)
          .toList(),
    );
  }
}

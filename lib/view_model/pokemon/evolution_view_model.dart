import 'package:pokedex/model/pokemon/pokemon_evolution_model.dart';
import 'package:pokedex/utils/end_Points/end_point.dart';

List<Evolution> parseEvolutionChain(Map<String, dynamic> chain) {
  List<Evolution> evolutions = [];

  Evolution currentEvolution = Evolution(
    name: chain['species']['name'],
    imageUrl:
        '$pokedexEvolutionChain${getPokemonIdFromUrl(chain['species']['url'])}.png',
  );

  evolutions.add(currentEvolution);

  while (chain['evolves_to'] != null && chain['evolves_to'].isNotEmpty) {
    chain = chain['evolves_to'][0];
    currentEvolution = Evolution(
      name: chain['species']['name'],
      imageUrl:
          '$pokedexEvolutionChain${getPokemonIdFromUrl(chain['species']['url'])}.png',
    );
    evolutions.add(currentEvolution);
  }

  return evolutions;
}

int getPokemonIdFromUrl(String url) {
  final uri = Uri.parse(url);
  final segments = uri.pathSegments;
  return int.parse(segments[segments.length - 2]);
}

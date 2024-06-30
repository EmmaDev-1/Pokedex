import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon_model.dart';

class EvolutionSection extends StatelessWidget {
  final Pokemon pokemon;

  const EvolutionSection({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Evolution Chain",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: pokemon.evolutions.map((evolution) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Image.network(
                      evolution.imageUrl,
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(width: 20),
                    Text(
                      evolution.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

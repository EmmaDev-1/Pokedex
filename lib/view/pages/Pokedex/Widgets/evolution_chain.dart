import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon_model.dart';

class EvolutionSection extends StatelessWidget {
  final Pokemon pokemon;
  final Color color;

  const EvolutionSection({Key? key, required this.pokemon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Column(
            children: List.generate(pokemon.evolutions.length, (index) {
              return Column(
                children: [
                  Center(
                    child: Card(
                      color: color,
                      elevation: 3,
                      margin: EdgeInsets.all(20),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 50,
                            right: -130,
                            child: Image.asset(
                              'assets/images/pokeball.png',
                              scale: 2.5,
                              color: Color.fromARGB(82, 255, 255, 255),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                pokemon.evolutions[index].name.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Image.network(
                                pokemon.evolutions[index].imageUrl,
                                width: 170,
                                height: 170,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (index < pokemon.evolutions.length - 1)
                    Icon(
                      Icons.keyboard_double_arrow_down_rounded,
                      size: 45,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

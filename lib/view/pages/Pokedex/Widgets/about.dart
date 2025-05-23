import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon/pokemon_model.dart';

class AboutSection extends StatelessWidget {
  final Pokemon pokemon;

  const AboutSection({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              pokemon.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Height: ${pokemon.height / 10}m",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontFamily: 'Quicksand-Bold',
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  Icon(
                    Icons.height,
                    color: Colors.blueGrey,
                  ),
                  Text(
                    "Weight: ${pokemon.weight / 10}kg",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontFamily: 'Quicksand-Bold',
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  Icon(
                    Icons.line_weight,
                    color: Colors.brown,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      Text(
                        "Gender: ${pokemon.gender}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      Icon(
                        Icons.male_rounded,
                        color: Colors.blue,
                      ),
                      Icon(
                        Icons.female,
                        color: Colors.pink,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      Text(
                        "Egg Groups: ${pokemon.eggGroups.join(', ')}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      Icon(
                        Icons.egg_outlined,
                        color: Colors.deepPurpleAccent,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Row(
                    children: [
                      Text(
                        "Egg Cycle: ${pokemon.eggCycle}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      Icon(
                        Icons.cyclone_outlined,
                        color: Colors.cyan,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

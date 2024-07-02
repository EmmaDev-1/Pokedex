import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/model/pokemon/pokemon_model.dart';
import 'package:pokedex/utils/get_Colors/get_pokemon_colors.dart';
import 'package:pokedex/view_model/region/species_view_model.dart';
import 'package:provider/provider.dart';

class Species extends StatelessWidget {
  const Species({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeciesViewModel>(
      builder: (context, speciesViewModel, child) {
        if (speciesViewModel.isLoading &&
            speciesViewModel.regionPokemons.isEmpty) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Lottie.asset(
                  'assets/animations/pokeballLoading.json',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          );
        } else {
          return pokemonsContent(speciesViewModel.regionPokemons, context);
        }
      },
    );
  }

  Widget pokemonsContent(List<Pokemon> pokemons, context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: AnimationLimiter(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: pokemons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 0.92,
                ),
                itemBuilder: (context, index) {
                  var pokemon = pokemons[index];
                  var color = getTypeColor(pokemon.types.first);

                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 1,
                    duration: const Duration(milliseconds: 600),
                    child: ScaleAnimation(
                      child: Container(
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(12)),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 55,
                              right: -70,
                              child: Image.asset(
                                'assets/images/pokeball.png',
                                scale: 3.5,
                                color: Color.fromARGB(82, 255, 255, 255),
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    pokemon.name.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      fontFamily: 'Quicksand-Bold',
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        alignment: Alignment.center,
                                        child: Wrap(
                                          spacing: 5.0,
                                          runSpacing: 5.0,
                                          children: pokemon.types.map((type) {
                                            return Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.18,
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.002),
                                              decoration: BoxDecoration(
                                                color:
                                                    Color.fromARGB(29, 0, 0, 0)
                                                        .withOpacity(0.20),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Text(
                                                type.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.035,
                                                  fontFamily: 'Quicksand-Bold',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      CachedNetworkImage(
                                        imageUrl: pokemon.imageUrl,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.14,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.34,
                                        placeholder: (context, url) =>
                                            Lottie.asset(
                                          'assets/animations/pokeballLoading.json',
                                          width: 40,
                                          height: 40,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (Provider.of<SpeciesViewModel>(context).isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Lottie.asset(
                  'assets/animations/pokeballLoading.json',
                  width: 60,
                  height: 60,
                  fit: BoxFit.fill,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

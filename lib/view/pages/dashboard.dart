import 'package:flutter/material.dart';
import 'package:pokedex/utils/Navigation/navegationAnimationRightLeft.dart';
import 'package:pokedex/view/components/features.dart';
import 'package:pokedex/view/pages/Items/items.dart';
import 'package:pokedex/view/pages/Regions/regions.dart';
import 'package:pokedex/view/pages/Pokedex/pokedex.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/view_model/pokemon/pokemon_view_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [searchSection(), featuresSection()],
        ),
      ),
    );
  }

  searchSection() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -55,
              right: -150,
              child: Image.asset(
                'assets/images/pokeball.png',
                scale: 1.8,
                color: Color.fromARGB(90, 255, 255, 255),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Text(
                    'Looking for Pokemons?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      fontFamily: 'QuickSand-Bold',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Consumer<PokemonViewModel>(
                    builder: (context, viewModel, child) {
                      return TextField(
                        onChanged: (query) {
                          viewModel.searchPokemon(query);
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'QuickSand',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search Pokémon",
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'QuickSand',
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 155, 155, 155),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 155, 155, 155),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  featuresSection() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        FeatureComponent(
          title: 'Pokedex',
          value1: -50,
          value2: -80,
          color: Colors.blue,
          onTap: () {
            Navigator.push(
              context,
              crearRuta(context, const PokedexPage()),
            );
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        FeatureComponent(
          title: 'Iteams',
          value1: -10,
          value2: -80,
          color: Colors.teal,
          onTap: () {
            Navigator.push(
              context,
              crearRuta(context, const ItemsPage()),
            );
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        FeatureComponent(
          title: 'Regions',
          value1: 30,
          value2: -80,
          color: Color.fromARGB(214, 97, 27, 109),
          onTap: () {
            Navigator.push(
              context,
              crearRuta(context, const RegionPage()),
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/view/pages/Pokedex/Widgets/about.dart';
import 'package:pokedex/view/pages/Pokedex/Widgets/base_stats.dart';
import 'package:pokedex/view/pages/Pokedex/Widgets/evolution_chain.dart';
import 'package:pokedex/view/pages/Pokedex/Widgets/moves.dart';

class PokemonDetails extends StatefulWidget {
  final Pokemon pokemon;
  final Color color;
  PokemonDetails({super.key, required this.pokemon, required this.color});

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Número de pestañas

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        body: Column(
          children: [
            topStatsSection(),
            Expanded(
              child: TabBarView(
                children: [
                  AboutSection(pokemon: widget.pokemon),
                  BaseStatsSection(
                      pokemon: widget.pokemon, color: widget.color),
                  EvolutionSection(pokemon: widget.pokemon),
                  MovesSection(pokemon: widget.pokemon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  topStatsSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        color: widget.color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Positioned(
            top: 80,
            right: -80,
            child: Image.asset(
              'assets/images/pokeball.png',
              scale: 1.7,
              color: Color.fromARGB(87, 255, 255, 255),
            ),
          ),
          Column(
            children: [
              Text(
                widget.pokemon.name.toUpperCase(),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.09,
                  fontFamily: 'Quicksand-Bold',
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 15.0,
                      runSpacing: 5.0,
                      children: widget.pokemon.types.map((type) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: MediaQuery.of(context).size.height * 0.035,
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.002),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(144, 255, 255, 255)
                                .withOpacity(0.20),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            type.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Image.network(
                widget.pokemon.imageUrl,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.55,
              ),
              TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Color.fromARGB(255, 214, 214, 214),
                indicatorColor: Colors.white,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: "About"),
                  Tab(text: "Base Stats"),
                  Tab(text: "Evolution"),
                  Tab(text: "Moves"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

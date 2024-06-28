// view/pokedex.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokedex/utils/get_colors/get_pokemon_colors.dart';
import 'package:pokedex/view/components/drawer.dart';
import 'package:pokedex/view_model/pokemon_view_model.dart';
import 'package:provider/provider.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PokemonViewModel(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: DrawerMenu(),
        body: CustomScrollView(
          slivers: [appBarContent(), pokemonsContent()],
        ),
      ),
    );
  }

  appBarContent() {
    return SliverAppBar(
      centerTitle: true,
      pinned: true,
      expandedHeight: MediaQuery.of(context).size.height * 0.2,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var rate = (constraints.biggest.height - kToolbarHeight) /
              (MediaQuery.of(context).size.height * 0.18 - kToolbarHeight);
          var visible = rate < 0.5;
          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            title: visible
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.055,
                    width: MediaQuery.of(context).size.width * 1,
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.02,
                      bottom: MediaQuery.of(context).size.height * 0.02,
                    ),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Text(
                      "Pokedex",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontFamily: 'Quicksand-Bold',
                        color: Theme.of(context).colorScheme.inversePrimary,
                        letterSpacing:
                            MediaQuery.of(context).size.width * 0.015,
                      ),
                    ),
                  )
                : null,
            background: Image.asset('assets/images/pokemon.png'),
            collapseMode: CollapseMode.none,
          );
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(12.0),
        child: Container(
          height: 8,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.05,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0.6,
                blurRadius: 6,
                offset: const Offset(0, -6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pokemonsContent() {
    return SliverToBoxAdapter(
      child: Consumer<PokemonViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AnimationLimiter(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: viewModel.pokemons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Número de columnas
                    crossAxisSpacing: 10.0, // Espacio horizontal entre columnas
                    mainAxisSpacing: 15.0, // Espacio vertical entre filas
                    childAspectRatio: 0.92, // Proporción del aspecto del hijo
                  ),
                  itemBuilder: (context, index) {
                    var pokemon = viewModel.pokemons[index];
                    var color = getTypeColor(pokemon.types.first);

                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 2,
                      duration: const Duration(milliseconds: 500),
                      child: ScaleAnimation(
                        child: Card(
                          color: color,
                          elevation: 15,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 55,
                                right: -70,
                                child: Image.asset(
                                  'assets/images/pokeball.png',
                                  scale: 3.5,
                                  color: Color.fromARGB(66, 255, 255, 255),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          alignment: Alignment.center,
                                          child: Wrap(
                                            spacing: 5.0,
                                            runSpacing: 5.0,
                                            children: pokemon.types.map((type) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06,
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        104, 255, 255, 255),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  type,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.035,
                                                    fontFamily: 'Quicksand',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Image.network(
                                            pokemon.imageUrl,
                                            height: 100,
                                            width: 100,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 100,
                                              );
                                            },
                                          ),
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
            );
          }
        },
      ),
    );
  }
}

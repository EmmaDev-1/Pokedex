import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/utils/Navigation/navegationAnimationRightLeft.dart';
import 'package:pokedex/utils/get_Colors/get_pokemon_colors.dart';
import 'package:pokedex/view/pages/Pokedex/pokemon_details.dart';
import 'package:pokedex/view/pages/settings.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/view_model/pokemon/pokemon_view_model.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<PokemonViewModel>(context, listen: false).fetchPokemons();
    }
  }

  void _onSearchChanged() {
    Provider.of<PokemonViewModel>(context, listen: false)
        .searchPokemon(_searchController.text);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          appBarContent(),
          pokemonsContent(),
        ],
      ),
    );
  }

  Widget appBarContent() {
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
            background: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 65,
                  ),
                  Image.asset(
                    'assets/images/pokemon.png',
                    scale: 4.5,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      actions: [
        AnimSearchBar(
          prefixIcon: Icon(
            Icons.search,
            weight: 15,
          ),
          width: MediaQuery.of(context).size.width * 0.75,
          textController: _searchController,
          color: Colors.transparent,
          boxShadow: false,
          textFieldColor: Theme.of(context).colorScheme.primary,
          helpText: "Search Pokémon",
          closeSearchOnSuffixTap: true,
          onSuffixTap: () {
            _searchController.clear();
            Provider.of<PokemonViewModel>(context, listen: false)
                .searchPokemon('');
          },
          onSubmitted: (String) {},
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              crearRuta(context, const SettingsPage()),
            );
          },
        ),
      ],
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

  Widget pokemonsContent() {
    return SliverToBoxAdapter(
      child: Consumer<PokemonViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.pokemons.isEmpty) {
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: AnimationLimiter(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: viewModel.filteredPokemons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Número de columnas
                        crossAxisSpacing:
                            10.0, // Espacio horizontal entre columnas
                        mainAxisSpacing: 15.0, // Espacio vertical entre filas
                        childAspectRatio:
                            0.92, // Proporción del aspecto del hijo
                      ),
                      itemBuilder: (context, index) {
                        var pokemon = viewModel.filteredPokemons[index];
                        var color = getTypeColor(pokemon.types.first);

                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 1,
                          duration: const Duration(milliseconds: 600),
                          child: ScaleAnimation(
                            child: OpenContainer(
                              transitionType: ContainerTransitionType.fade,
                              openBuilder: (context, _) => PokemonDetails(
                                  pokemon: pokemon, color: color),
                              closedElevation: 15,
                              closedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              closedColor: color,
                              closedBuilder: (context, openContainer) => Stack(
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
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1,
                                              alignment: Alignment.center,
                                              child: Wrap(
                                                spacing: 5.0,
                                                runSpacing: 5.0,
                                                children:
                                                    pokemon.types.map((type) {
                                                  return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.18,
                                                    padding: EdgeInsets.all(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.002),
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                              29, 0, 0, 0)
                                                          .withOpacity(0.20),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Text(
                                                      type.toUpperCase(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.035,
                                                        fontFamily:
                                                            'Quicksand-Bold',
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
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.14,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.34,
                                              placeholder: (context, url) =>
                                                  Lottie.asset(
                                                'assets/animations/pokeballLoading.json',
                                                width: 40,
                                                height: 40,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
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
                if (viewModel.isLoading)
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
            );
          }
        },
      ),
    );
  }
}

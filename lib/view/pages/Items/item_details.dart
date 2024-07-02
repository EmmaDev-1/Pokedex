import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/utils/Navigation/navegationAnimationRightLeft.dart';
import 'package:pokedex/utils/pokedex_voice.dart/pokedex_voice.dart';
import 'package:pokedex/utils/pokedex_voice.dart/voice_provider.dart';
import 'package:pokedex/view/pages/settings.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/model/item/item_model.dart';
import 'package:pokedex/view_model/item/item_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemDetailsPage extends StatefulWidget {
  final Item item;

  const ItemDetailsPage({Key? key, required this.item}) : super(key: key);

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  final PokedexVoice ttsService = PokedexVoice();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final itemViewModel = Provider.of<ItemViewModel>(context, listen: false);
      itemViewModel.fetchCategory(widget.item.categoryUrl);
    });
    _speakPokemonDetails();
  }

  @override
  void dispose() {
    ttsService.stop();
    super.dispose();
  }

  Future<void> _speakPokemonDetails() async {
    if (Provider.of<VoiceProvider>(context, listen: false).isVoiceEnabled) {
      String text =
          "${widget.item.name}. This is a ${widget.item.category} category item. ${widget.item.effect}. Here are some similar items.";
      await ttsService.speak(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ItemViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(
              child: Lottie.asset(
                'assets/animations/pokeballLoading.json',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: -50,
                    right: -150,
                    child: Image.asset(
                      'assets/images/pokeball.png',
                      scale: 1.7,
                      color: Color.fromARGB(110, 247, 35, 35),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              )),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  crearRuta(context, const SettingsPage()),
                                );
                              },
                              icon: Icon(
                                Icons.settings,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              )),
                        ],
                      ),
                      CachedNetworkImage(
                        imageUrl: widget.item.imageUrl,
                        height: 150,
                        width: 150,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.item.name.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontFamily: 'QuickSand-Bold',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            'Category: ${widget.item.category}',
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              fontFamily: 'QuickSand-Bold',
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          '${widget.item.effect}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.018,
                            fontFamily: 'QuickSand',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Similar Items',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          fontFamily: 'QuickSand-Bold',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (viewModel.category == null)
                        Center(
                          child: Lottie.asset(
                            'assets/animations/pokeballLoading.json',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        )
                      else
                        GridView.builder(
                          padding: const EdgeInsets.all(10.0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1,
                          ),
                          itemCount: viewModel.category!.items.length,
                          itemBuilder: (context, index) {
                            final similarItem =
                                viewModel.category!.items[index];
                            return Card(
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: similarItem.imageUrl,
                                    height: 80,
                                    width: 80,
                                    placeholder: (context, url) => Lottie.asset(
                                      'assets/animations/pokeballLoading.json',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fill,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    similarItem.name,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      fontFamily: 'QuickSand-Bold',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

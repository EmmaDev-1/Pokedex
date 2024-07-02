import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/utils/Navigation/navegationAnimationRightLeft.dart';
import 'package:pokedex/view/pages/Items/item_details.dart';
import 'package:pokedex/view/pages/settings.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/view_model/item/item_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final itemViewModel = Provider.of<ItemViewModel>(context, listen: false);
      itemViewModel.fetchItems();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final itemViewModel = Provider.of<ItemViewModel>(context, listen: false);
      itemViewModel.fetchNextItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Items',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: MediaQuery.of(context).size.height * 0.03,
            fontFamily: 'QuickSand-Bold',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
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
        centerTitle: true,
      ),
      body: Consumer<ItemViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.items.isEmpty) {
            return Center(
              child: Lottie.asset(
                'assets/animations/pokeballLoading.json',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            );
          } else {
            return Stack(
              children: [
                Positioned(
                  top: 480,
                  right: -150,
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    scale: 1.7,
                    color: Color.fromARGB(110, 247, 35, 35),
                  ),
                ),
                ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      viewModel.items.length + (viewModel.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < viewModel.items.length) {
                      final item = viewModel.items[index];
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: item.imageUrl,
                          width: 60,
                          height: 80,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        title: Text(
                          item.name.toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontFamily: 'QuickSand-Bold',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            crearRuta(context, ItemDetailsPage(item: item)),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Lottie.asset(
                          'assets/animations/pokeballLoading.json',
                          width: 75,
                          height: 75,
                          fit: BoxFit.fill,
                        ),
                      );
                    }
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }
}

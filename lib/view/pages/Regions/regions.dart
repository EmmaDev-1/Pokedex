import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/utils/Navigation/navegationAnimationRightLeft.dart';
import 'package:pokedex/view/pages/Regions/region_details.dart';
import 'package:pokedex/view/pages/settings.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/view_model/region/region_view_model.dart';

class RegionPage extends StatelessWidget {
  const RegionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Regions',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'QuickSand-Bold',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
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
      ),
      body: Consumer<RegionViewModel>(
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
            return ListView.builder(
              itemCount: viewModel.regions.length,
              itemBuilder: (context, index) {
                final region = viewModel.regions[index];
                return Container(
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width * 0.34,
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01,
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: OpenContainer(
                    transitionType: ContainerTransitionType.fade,
                    closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    openBuilder: (context, _) => RegionDetailsPage(
                      regionName: region.name,
                      regionImageUrl: region.imageUrl,
                      regionUrl: region.url,
                    ),
                    closedElevation: 15,
                    closedBuilder: (context, openContainer) => Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      width: MediaQuery.of(context).size.width * 0.34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(region.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          region.name.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            fontFamily: 'QuickSand-Bold',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

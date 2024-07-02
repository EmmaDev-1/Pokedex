import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/view_model/region/region_view_model.dart';
import 'package:provider/provider.dart';

Widget locationsTab() {
  return Consumer<RegionViewModel>(
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
        return Stack(
          children: [
            Positioned(
              top: 110,
              right: -150,
              child: Image.asset(
                'assets/images/pokeball.png',
                scale: 1.7,
                color: Color.fromARGB(112, 158, 158, 158),
              ),
            ),
            ListView.builder(
              itemCount: viewModel.locations.length,
              itemBuilder: (context, index) {
                final location = viewModel.locations[index];
                return Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    location.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Quicksand-Bold',
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      }
    },
  );
}

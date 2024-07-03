import 'package:flutter/material.dart';
import 'package:pokedex/utils/get_Colors/get_pokemon_colors.dart';
import 'package:pokedex/view_model/region/region_view_model.dart';
import 'package:provider/provider.dart';

Widget typesTab() {
  return Consumer<RegionViewModel>(
    builder: (context, viewModel, child) {
      if (viewModel.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (viewModel.generation == null) {
        return Center(
          child: Text("No data available"),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            itemCount: viewModel.generation!.types.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 3, // Proporción del aspecto del hijo
            ),
            itemBuilder: (context, index) {
              final type = viewModel.generation!.types[index];
              final color = getTypeColor(type);

              return Container(
                decoration: BoxDecoration(
                  color: color,
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
                alignment: Alignment.center,
                child: Text(
                  type.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontFamily: 'Quicksand-Bold',
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        );
      }
    },
  );
}

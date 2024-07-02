import 'package:flutter/material.dart';
import 'package:pokedex/utils/Navigation/navegationAnimationRightLeft.dart';
import 'package:pokedex/view/pages/Locations/locations.dart';
import 'package:pokedex/view/pages/Locations/species.dart';
import 'package:pokedex/view/pages/Locations/types.dart';
import 'package:pokedex/view/pages/settings.dart';
import 'package:pokedex/view_model/region/species_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/view_model/region/region_view_model.dart';

class RegionDetailsPage extends StatefulWidget {
  final String regionName;
  final String regionImageUrl;
  final String regionUrl;

  const RegionDetailsPage({
    Key? key,
    required this.regionName,
    required this.regionImageUrl,
    required this.regionUrl,
  }) : super(key: key);

  @override
  State<RegionDetailsPage> createState() => _RegionDetailsPageState();
}

class _RegionDetailsPageState extends State<RegionDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final regionViewModel =
          Provider.of<RegionViewModel>(context, listen: false);
      regionViewModel.fetchLocationsForRegion(widget.regionUrl).then((_) {
        final generation = regionViewModel.generation;
        if (generation != null) {
          final speciesViewModel =
              Provider.of<SpeciesViewModel>(context, listen: false);
          speciesViewModel.fetchRegionPokemons(generation.pokemonSpecies);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        body: Column(
          children: [
            topSection(),
            Expanded(
              child: TabBarView(
                children: [
                  locationsTab(),
                  Species(),
                  typesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.regionImageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
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
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.45),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.45),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        crearRuta(context, const SettingsPage()),
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.45),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Text(
              widget.regionName.toUpperCase(),
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Quicksand-Bold',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.19,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Color.fromARGB(255, 214, 214, 214),
              indicatorColor: Colors.white,
              dividerColor: Colors.transparent,
              labelPadding: EdgeInsets.zero,
              tabs: [
                Tab(text: "Locations"),
                Tab(text: "Pokemon Species"),
                Tab(text: "Types"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

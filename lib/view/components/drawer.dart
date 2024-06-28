import 'package:flutter/material.dart';
import 'package:pokedex/utils/Navigation/navegationAnimationRightLeft.dart';
import 'package:pokedex/view/components/drawer_tile.dart';
import 'package:pokedex/view/pages/settings.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          DrawerTile(
            title: "Settings",
            leading: Icon(
              Icons.settings_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                crearRuta(context, const SettingsPage()),
              );
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ],
      ),
    );
  }
}

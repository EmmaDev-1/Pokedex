import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/utils/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Settings",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.065,
            color: Theme.of(context).colorScheme.inversePrimary,
            fontFamily: 'QuickSand-Bold',
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
          size: 25,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.2), // Color de la sombra con opacidad
              spreadRadius: 2, // Extensión de la sombra
              blurRadius: 5, // Difuminado de la sombra
              offset: Offset(0, 3), // Desplazamiento de la sombra
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        margin: EdgeInsets.only(left: 25, right: 25, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Light Mode',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontFamily: 'QuickSand-Bold',
              ),
            ),
            CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isdarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme())
          ],
        ),
      ),
    );
  }
}

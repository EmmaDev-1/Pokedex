import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/utils/pokedex_voice.dart/voice_provider.dart';
import 'package:pokedex/utils/theme/theme_provider.dart';
import 'package:pokedex/view/pages/dashboard.dart';
import 'package:pokedex/view_model/item/item_view_model.dart';
import 'package:pokedex/view_model/region/region_view_model.dart';
import 'package:pokedex/view_model/pokemon/pokemon_view_model.dart';
import 'package:pokedex/view_model/region/species_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PokemonViewModel()),
        ChangeNotifierProvider(create: (_) => VoiceProvider()),
        ChangeNotifierProvider(create: (_) => RegionViewModel()),
        ChangeNotifierProvider(create: (_) => SpeciesViewModel()),
        ChangeNotifierProvider(create: (_) => ItemViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: DashboardPage(),
    );
  }
}

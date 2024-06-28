import 'dart:ui';

import 'package:flutter/material.dart';

Map<String, Color> typeColors = {
  'grass': Colors.green,
  'fire': Colors.red,
  'water': Colors.blue,
  'electric': Colors.yellow,
  'ice': Colors.lightBlue,
  'fighting': Colors.brown,
  'poison': Colors.purple,
  'ground': Colors.orange,
  'flying': Colors.indigo,
  'psychic': Colors.pink,
  'bug': Colors.lightGreen,
  'rock': Colors.grey,
  'ghost': Colors.deepPurple,
  'dragon': Colors.deepOrange,
  'dark': Colors.black,
  'steel': Colors.blueGrey,
  'fairy': Colors.pinkAccent,
};

Color getTypeColor(String type) {
  return typeColors[type] ?? Colors.grey;
}

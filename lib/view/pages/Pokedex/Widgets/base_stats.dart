import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon/pokemon_model.dart';

class BaseStatsSection extends StatelessWidget {
  final Pokemon pokemon;
  final Color color;

  const BaseStatsSection({Key? key, required this.pokemon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          StatBar(
            name: "HP",
            value: pokemon.stats[0].value,
            color: color,
            icon: Icons.favorite,
          ),
          StatBar(
            name: "Attack",
            value: pokemon.stats[1].value,
            color: color,
            icon: Icons.flash_on,
          ),
          StatBar(
            name: "Defense",
            value: pokemon.stats[2].value,
            color: color,
            icon: Icons.security,
          ),
          StatBar(
            name: "Speed Attack",
            value: pokemon.stats[3].value,
            color: color,
            icon: Icons.whatshot,
          ),
          StatBar(
            name: "Speed Defense",
            value: pokemon.stats[4].value,
            color: color,
            icon: Icons.shield,
          ),
          StatBar(
            name: "Speed",
            value: pokemon.stats[5].value,
            color: color,
            icon: Icons.speed,
          ),
        ],
      ),
    );
  }
}

class StatBar extends StatefulWidget {
  final String name;
  final int value;
  final Color color;
  final IconData icon;

  const StatBar(
      {Key? key,
      required this.name,
      required this.value,
      required this.color,
      required this.icon})
      : super(key: key);

  @override
  _StatBarState createState() => _StatBarState();
}

class _StatBarState extends State<StatBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: widget.value.toDouble())
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              widget.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          SizedBox(width: 10),
          Icon(widget.icon, color: widget.color),
          SizedBox(width: 10),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 20,
                  width: (_animation.value / 200) *
                      MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      "${_animation.value.toInt()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FeatureComponent extends StatelessWidget {
  final String title;
  final double value1;
  final double value2;
  final Color color;
  final void Function()? onTap;
  const FeatureComponent({
    super.key,
    required this.title,
    required this.value1,
    required this.value2,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.height * 0.3,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
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
        child: Stack(
          children: [
            Positioned(
                top: value1,
                right: value2,
                child: Image.asset(
                  'assets/images/pokeball.png',
                  scale: 4,
                  color: Color.fromARGB(120, 241, 241, 241),
                )),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    fontFamily: 'QuickSand-Bold',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

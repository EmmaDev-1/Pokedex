import 'package:flutter/material.dart';

PageRouteBuilder crearRutaIzquierdaADerecha(
    BuildContext context, Widget destino) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Stack(
        children: [
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(1.0, 0.0), // Invertido para izquierda a derecha
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
          ),
          SlideTransition(
            position: Tween<Offset>(
              begin:
                  const Offset(-1.0, 0.0), // Invertido para izquierda a derecha
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: destino,
          ),
        ],
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}

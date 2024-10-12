import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final int duration;
  final Curve curveAnimation;

  CustomPageRoute({
    this.curveAnimation = Curves.easeIn,
    required this.page,
    this.duration = 300,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            var curve = curveAnimation;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(
              curve: curve,
            ));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: duration),
        );
}

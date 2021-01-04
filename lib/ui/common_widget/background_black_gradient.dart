import 'package:flutter/material.dart';

class BackgroundBlackGradient extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;

  const BackgroundBlackGradient({Key key, this.padding, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.9),
          ],
          stops: [0.3, 0.5, 0.7, 0.9],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: child,
    );
  }
}

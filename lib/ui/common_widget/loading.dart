import 'package:flutter/material.dart';

class LoadingProgress extends StatelessWidget {
  final double width;
  final double height;

  const LoadingProgress({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      child: CircularProgressIndicator(),
    );
  }
}

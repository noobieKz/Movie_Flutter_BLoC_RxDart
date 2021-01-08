import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final double width;
  final double height;

  const EmptyListWidget({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: width == null ? size.width : width,
      height: height == null ? size.height : height,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: height != null ? height / 3 : 180 / 3,
            color: Colors.white70,
          ),
          Text(
            "Oops! No data here...",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

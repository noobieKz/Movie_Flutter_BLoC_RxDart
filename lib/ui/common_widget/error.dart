import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorLoading extends StatelessWidget {
  final String message;
  final double width;
  final double height;

  const ErrorLoading({Key key, this.message, this.width, @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.stackOverflow,
            color: Colors.white70,
            size: height / 3,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 4,
          ),
          FlatButton(
              color: Colors.white10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onPressed: () {},
              child: Text("Retry", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}

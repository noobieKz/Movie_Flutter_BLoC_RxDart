import 'package:flutter/material.dart';

import '../../constants.dart';

class CommonButton extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final EdgeInsetsGeometry margin;
  final VoidCallback onClick;

  const CommonButton(
      {Key key, this.icon, this.title, this.margin, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: bgColor),
      child: FlatButton(
        splashColor: kColorChipItem,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          onClick();
        },
        child: ListTile(
          leading: icon,
          title: title,
        ),
      ),
    );
  }
}

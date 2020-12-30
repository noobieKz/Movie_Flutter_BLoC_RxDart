import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewAllButton extends StatelessWidget {
  final String label;
  final Widget icon;

  const ViewAllButton({Key key, this.label, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.black12,
      splashColor: Colors.blueGrey.withOpacity(0.4),
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(children: [
            Text(
              label,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.8),
                  ),
            ),
            Spacer(),
            icon,
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/rounte_config/route_config.dart';

class DrawerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: ListView(
        children: [
          Container(
            color: bgColor,
            alignment: Alignment.center,
            height: 250,
            child: Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.yellow.shade800,
            ),
          ),
          _buildItem("Home", Icons.home, () {
            close(context);
          }),
          _buildItem("Favorite Movies", Icons.favorite, () {
            close(context);
            Navigator.pushNamed(context, RouteConfig.ROUTE_FAVORITE);
          }),
          _buildItem("Watched Movies", Icons.bookmark_outlined, () {
            close(context);
          }),
          Divider(
            color: Colors.white24,
          ),
          _buildItem("About", Icons.info, () {
            close(context);
          }),
          _buildItem("Logout", Icons.logout, () {
            close(context);
          }),
        ],
      ),
    );
  }

  void close(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _buildItem(String title, IconData iconData, Function onClick) {
    return Material(
      color: bgColor,
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              SizedBox(
                width: 24,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

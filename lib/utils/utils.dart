import 'package:flutter/material.dart';

import '../rounte_config/route_config.dart';

void goDetailScreen(BuildContext context, int id) {
  Navigator.pushNamed(context, RouteConfig.ROUTE_MOVIE_DETAIL, arguments: id);
}

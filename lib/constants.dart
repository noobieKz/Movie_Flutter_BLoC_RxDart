import 'package:flutter/material.dart';
import 'package:flutter_sample/data/local/category.dart';

// Colos that use in our app
const kSecondaryColor = Color(0xFFf48210);
const kTextColor = Colors.white;
const kTextLightColor = Color(0xFF9A9BB2);
const kFillStarColor = Color(0xFFFCC419);
const Color kColorChipItem = const Color(0xFF192431);
const Color kColorItemDarker = const Color(0xFF002431);

const bgColor = Color(0xFF243142);
const kDefaultPadding = 20.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 4),
  blurRadius: 4,
  color: Colors.black26,
);

const listCategory = [
  Category(name: "Now Playing", keyQuery: "now_playing"),
  Category(name: "Popular", keyQuery: "popular"),
  Category(name: "Top Rated", keyQuery: "top_rated"),
  Category(name: "Coming Soon", keyQuery: "upcoming"),
];

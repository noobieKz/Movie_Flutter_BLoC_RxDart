import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/data/api_movie.dart';
import 'package:flutter_sample/data/movie_list_response.dart';
import 'package:flutter_sample/ui/common/view_all_button.dart';
import 'package:flutter_sample/ui/home/widgets/category_list_widget.dart';
import 'package:flutter_sample/ui/home/widgets/genre_list_widget.dart';
import 'package:flutter_sample/ui/home/widgets/movie_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiMovie _apiMovie = ApiMovie();
  Future<MovieListResponse> movies;

  @override
  void initState() {
    movies = _apiMovie.getPlayingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: buildAppBar(),
        body: FutureBuilder<MovieListResponse>(
            future: movies,
            builder: (
              BuildContext context,
              AsyncSnapshot<MovieListResponse> snapshot,
            ) {
              if (snapshot.hasData) {
                List<Movie> movies = snapshot.data.results;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CategoryListWidget(),
                      MovieListSlider(
                        movies: movies,
                      ),
                      SizedBox(height: 16,),
                      GenreListWidget(
                        genres: [
                          "Wtf",
                          "Wtf this shit",
                          "Some genere there",
                          "Oh noo!!",
                          "Wtf",
                          "Wtf this shit",
                          "Some genere there",
                          "Oh noo!!",
                          "Wtf",
                          "Wtf this shit",
                          "Some genere there",
                          "Oh noo!!"
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }));
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Image.asset(
        'assets/images/movie_logo.png',
        width: 150,
      ),
      leading: IconButton(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        color: Colors.white,
        iconSize: 20,
        icon: FaIcon(FontAwesomeIcons.listUl),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          color: Colors.white,
          iconSize: 20,
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          icon: FaIcon(FontAwesomeIcons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}

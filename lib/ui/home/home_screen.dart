import 'package:flutter/material.dart';
import 'package:flutter_sample/data/api_movie.dart';
import 'package:flutter_sample/data/movie_list_response.dart';
import 'package:flutter_sample/ui/home/widgets/category_list_widget.dart';
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
                      InkWell(
                        highlightColor: Colors.black12,
                        splashColor: Colors.blueGrey.withOpacity(0.4),
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(children: [
                              Text(
                                "Show More",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                              ),
                              Spacer(),
                              FaIcon(
                                FontAwesomeIcons.arrowRight,
                                size: 20,
                                color: Colors.white.withOpacity(0.8),
                              )
                            ]),
                          ),
                        ),
                      ),
                      MovieListSlider(
                        movies: movies,
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
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        color: Colors.white,
        icon: FaIcon(FontAwesomeIcons.listUl),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          icon: FaIcon(FontAwesomeIcons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}

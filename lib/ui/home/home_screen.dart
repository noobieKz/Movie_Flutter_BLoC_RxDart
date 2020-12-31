import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/home/home_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sample/ui/home/widgets/category_list_widget.dart';
import 'package:flutter_sample/ui/home/widgets/genre_list_widget.dart';
import 'package:flutter_sample/ui/home/widgets/movie_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import 'widgets/movie_list_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = context.read<HomeBloc>();
    _homeBloc.getDiscoverMovies(1);
    _homeBloc.getGenreList();
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CategoryListWidget(
                onCategoryChange: (category) =>
                    _homeBloc.changeCategory(category),
              ),
              MovieListSlider(),
              SizedBox(
                height: 8,
              ),
              GenreListWidget(),
              SizedBox(
                height: 8,
              ),
              MovieListWidget(),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }

  Widget _buildAppBar() {
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

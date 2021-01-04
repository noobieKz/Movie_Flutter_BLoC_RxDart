import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/di/app_module.dart';
import 'package:flutter_sample/rounte_config/route_config.dart';
import 'package:flutter_sample/ui/home/home_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sample/ui/home/widgets/category_list_widget.dart';
import 'package:flutter_sample/ui/home/widgets/genre_list_widget.dart';
import 'package:flutter_sample/ui/home/widgets/movie_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import 'widgets/movie_list_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      bloc: locator<HomeBloc>(),
      child: _HomeWidget(),
    );
  }
}

class _HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<_HomeWidget> {
  HomeBloc _homeBloc;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    _homeBloc = context.read<HomeBloc>();
    _homeBloc.getDiscoverMovies(1);
    _homeBloc.getGenreList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
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
            MovieListWidget(
              onItemClick: (movie) => Navigator.pushNamed(
                  context, RouteConfig.ROUTE_MOVIE_DETAIL,
                  arguments: movie.id),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: kColorChipItem,
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Hero(
        tag: "logo",
        child: Image.asset(
          'assets/images/movie_logo.png',
          width: 120,
        ),
      ),
      leading: IconButton(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        color: Colors.white,
        iconSize: 20,
        icon: FaIcon(FontAwesomeIcons.listUl),
        onPressed: () {
          _drawerKey.currentState.openDrawer();
        },
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

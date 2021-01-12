import 'package:flutter/material.dart';
import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/base/base_state.dart';
import 'package:flutter_sample/data/local/entities/movie_entity.dart';
import 'package:flutter_sample/di/app_module.dart';
import 'package:flutter_sample/ui/favorite_movies/favorite_movie_bloc.dart';
import 'package:flutter_sample/utils/exts.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class FavoriteMovieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteMovieBloc>(
      bloc: locator<FavoriteMovieBloc>(),
      child: FavoriteMovieWidget(),
    );
  }
}

class FavoriteMovieWidget extends StatefulWidget {
  @override
  _FavoriteMovieWidgetState createState() => _FavoriteMovieWidgetState();
}

class _FavoriteMovieWidgetState extends State<FavoriteMovieWidget> {
  FavoriteMovieBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<FavoriteMovieBloc>();
    _bloc.getFavoriteMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(),
      body: StreamBuilder<BaseState>(
        stream: _bloc.favMovieStream,
        builder: (BuildContext context, AsyncSnapshot<BaseState> snapshot) {
          BaseState state = snapshot.data;
          if (snapshot.hasData && state is StateLoaded<List<MovieEntity>>) {
            loggerTag("test", state.value.length.toString());
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: state.value.length,
              itemBuilder: (BuildContext context, int index) {
                var item = state.value[index];
                return Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.white70,
                  ),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                    title: Text(
                      item.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    children: [
                      Text(
                        item.description,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      centerTitle: true,
      backgroundColor: bgColor,
      elevation: 2,
      title: Text(
        "Favorite Movies",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

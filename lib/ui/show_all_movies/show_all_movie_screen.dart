import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/local/category.dart';
import 'package:flutter_sample/data/remote/response/genre_list_response.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/di/app_module.dart';
import 'package:flutter_sample/utils/utils.dart';
import 'package:flutter_sample/vo/type_show_all.dart';
import 'package:flutter_sample/ui/common_widget/error.dart';
import 'package:flutter_sample/ui/common_widget/loading.dart';
import 'package:flutter_sample/ui/common_widget/movie_item.dart';
import 'package:flutter_sample/ui/home/home_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'show_all_movie_bloc.dart';

class ShowAllMovieScreen extends StatelessWidget {
  final TypeShowAll typeShowAll;

  const ShowAllMovieScreen({Key key, this.typeShowAll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShowAllMovieBloc>(
      bloc: locator<ShowAllMovieBloc>(),
      child: _ShowAllMovieWidget(
        typeShowAll: typeShowAll,
      ),
    );
  }
}

class _ShowAllMovieWidget extends StatefulWidget {
  final TypeShowAll typeShowAll;

  const _ShowAllMovieWidget({Key key, this.typeShowAll}) : super(key: key);

  @override
  _ShowAllMovieWidgetState createState() => _ShowAllMovieWidgetState();
}

class _ShowAllMovieWidgetState extends State<_ShowAllMovieWidget> {
  ShowAllMovieBloc _bloc;
  ScrollController _controller;

  @override
  void initState() {
    _bloc = context.read<ShowAllMovieBloc>();
    _bloc.getMovieByTypeShowFirstPage(widget.typeShowAll);
    _controller = ScrollController();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _bloc.requestMore(widget.typeShowAll);
      }
    });
    super.initState();
  }

  String _getTitle() {
    if (widget.typeShowAll.type == Type.CATEGORY) {
      Category category = widget.typeShowAll.data;
      return category.name;
    } else if (widget.typeShowAll.type == Type.GENRE) {
      Genre genre = widget.typeShowAll.data;
      return genre.name;
    } else if (widget.typeShowAll.type == Type.DISCOVER) {
      return "Discover";
    } else {
      return "Wtf";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 2,
        leading: IconButton(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            size: 20,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            icon: FaIcon(
              FontAwesomeIcons.exchangeAlt,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () {
            },
          ),
        ],
        title: Text(
          _getTitle(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: bgColor,
      body: StreamBuilder<BaseState>(
        stream: _bloc.moviesByCategory,
        builder: (BuildContext context, AsyncSnapshot<BaseState> snapshot) {
          if (snapshot.hasData) {
            BaseState state = snapshot.data;
            return _handleStreamState(state);
          } else {
            return ErrorLoading(
              message: "Fetch data not handle..",
              height: MediaQuery.of(context).size.height,
            );
          }
        },
      ),
    );
  }

  Widget _handleStreamState(BaseState state) {
    double maxHeight = MediaQuery.of(context).size.height;
    if (state is StateLoading) {
      return LoadingProgress(
        height: maxHeight,
      );
    } else if (state is StateLoaded<List<Movie>>) {
      List<Movie> movies = state.value;
      return Container(
        alignment: Alignment.center,
        child: GridView.builder(
          controller: _controller,
          padding: EdgeInsets.only(left: 10),
          physics: BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            if ((movies[index] == null) && _bloc.hasMoreData) {
              return Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator()),
              );
            }
            return MovieItem(
              movie: movies[index],
              width: 150,
              height: 180,
              onItemClick: (item) {
                goDetailScreen(context, item.id);
              },
              isCenter: true,
              titleSize: 16,
              ratingSize: 12,
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 3 / 5),
        ),
      );
    } else if (state is StateError) {
      return ErrorLoading(
        message: state.msgError,
        height: maxHeight,
      );
    } else {
      return ErrorLoading(
        message: "Unknown Error",
        height: maxHeight,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/data/remote/response/movie_list_response.dart';
import 'package:flutter_sample/di/app_module.dart';
import 'package:flutter_sample/ui/common_widget/error.dart';
import 'package:flutter_sample/ui/common_widget/loading.dart';
import 'package:flutter_sample/ui/common_widget/movie_item.dart';
import 'package:flutter_sample/ui/home/home_state.dart';
import 'package:provider/provider.dart';
import '../../utils.dart';
import 'search_bloc.dart';

class SearchScreen extends StatelessWidget {
  final String query;

  const SearchScreen({Key key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("searchScreen build " + query);
    return BlocProvider(
      bloc: locator<SearchBloc>(),
      child: SearchWidget(query: query,),
    );
  }
}

class SearchWidget extends StatefulWidget {
  final String query;

  const SearchWidget({Key key, this.query}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  SearchBloc _bloc;
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _bloc = context.read<SearchBloc>();
    print(widget.query);
    _bloc.search(widget.query);
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        // _bloc.requestMore(widget.typeShowAll);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: StreamBuilder<BaseState>(
        stream: _bloc.movieResults,
        builder: (BuildContext context, AsyncSnapshot<BaseState> snapshot) {
          if (snapshot.hasData) {
            BaseState state = snapshot.data;
            return _handleStreamState(state, context);
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

  Widget _handleStreamState(BaseState state, context) {
    double maxHeight = MediaQuery.of(context).size.height;
    if (state is StateLoading) {
      return LoadingProgress(
        height: maxHeight,
      );
    } else if (state is StateLoaded<List<Movie>>) {
      List<Movie> movies = state.value;
      print("eeeeeeee" + movies.length.toString());
      return Container(
        alignment: Alignment.center,
        child: GridView.builder(
          controller: _controller,
          padding: EdgeInsets.only(left: 10),
          physics: BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            // if ((movies[index] == null) && _bloc.hasMoreData) {
            //   return Container(
            //     alignment: Alignment.topCenter,
            //     child: SizedBox(
            //         width: 30, height: 30, child: CircularProgressIndicator()),
            //   );
            // }
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

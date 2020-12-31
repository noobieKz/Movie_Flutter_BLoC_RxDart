import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/data/remote/response/genre_list_response.dart';
import 'package:flutter_sample/ui/common/genre_card.dart';
import 'package:flutter_sample/ui/home/home_bloc.dart';
import 'package:flutter_sample/ui/home/home_state.dart';
import 'package:provider/provider.dart';

class GenreListWidget extends StatelessWidget {
  const GenreListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BaseState>(
      stream: context.watch<HomeBloc>().genresListStream,
      builder: (BuildContext context, AsyncSnapshot<BaseState> snapshot) {
        BaseState state = snapshot.data;
        if (snapshot.hasData && state is StateLoaded<List<Genre>>) {
          List<Genre> genres = state.value;
          return Container(
            height: 40,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 16),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return GenreCard(
                  genre: state.value[index],
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

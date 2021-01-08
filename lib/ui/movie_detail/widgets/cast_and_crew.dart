import 'package:flutter/material.dart';
import 'package:flutter_sample/data/remote/response/cast_crew_response.dart';
import 'package:flutter_sample/ui/common_widget/cast_card.dart';
import 'package:flutter_sample/ui/common_widget/empty_list_widget.dart';
import 'package:flutter_sample/ui/common_widget/error.dart';
import 'package:flutter_sample/ui/common_widget/loading.dart';
import 'package:flutter_sample/base/base_state.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../movie_detail_bloc.dart';

class CastAndCrew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BaseState>(
      stream: context.watch<MovieDetailBloc>().castCrewStream,
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
    );
  }

  Widget _handleStreamState(BaseState state, BuildContext context) {
    if (state is StateLoading) {
      return LoadingProgress(
        height: 160,
      );
    } else if (state is StateLoaded<CastCrewResponse>) {
      List<Cast> casts = state.value.cast;
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(left: kDefaultPadding, top: kDefaultPadding),
              child: Text(
                "Cast & Crew",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            (casts.isEmpty)
                ? EmptyListWidget(
                    height: 160,
                  )
                : SizedBox(
                    height: 160,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      scrollDirection: Axis.horizontal,
                      itemCount: casts.length,
                      itemBuilder: (context, index) =>
                          CastCard(cast: casts[index]),
                      physics: BouncingScrollPhysics(),
                    ),
                  )
          ],
        ),
      );
    } else if (state is StateError) {
      return ErrorLoading(
        message: state.msgError,
        height: 160,
      );
    } else {
      return ErrorLoading(
        message: "Unknown Error",
        height: 160,
      );
    }
  }
}

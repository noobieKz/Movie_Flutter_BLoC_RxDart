import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/home/home_bloc.dart';
import 'package:provider/provider.dart';

abstract class BaseBloc {
  void dispose();
}

class BlocProvider<T extends BaseBloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  @override
  _BlocProviderState createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends BaseBloc> extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      create: (BuildContext context) {
        return widget.bloc;
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    print("${widget.bloc.runtimeType} is dispose");
    super.dispose();
  }
}

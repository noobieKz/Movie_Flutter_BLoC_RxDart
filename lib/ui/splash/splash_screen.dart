import 'package:flutter/material.dart';
import 'package:flutter_sample/base/base_bloc.dart';
import 'package:flutter_sample/constants.dart';
import 'package:flutter_sample/di/app_module.dart';
import 'package:flutter_sample/rounte_config/route_config.dart';
import 'package:flutter_sample/ui/splash/splash_bloc.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      bloc: locator<SplashBloc>(),
      child: _SplashWidget(),
    );
  }
}

class _SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<_SplashWidget> {
  SplashBloc _splashBloc;

  @override
  void initState() {
    _splashBloc = context.read<SplashBloc>();
    _splashBloc.fakeLoading();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _splashBloc.splashStream.listen((event) {
      if (event == SplashState.DONE) {
        Navigator.pushReplacementNamed(context, RouteConfig.ROUTE_HOME);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: "logo",
            child: Image.asset(
              'assets/images/movie_logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Welcome",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }
}

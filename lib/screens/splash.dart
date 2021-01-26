import 'package:jitney_userSide/helpers/style.dart';
import 'package:jitney_userSide/widgets/loading.dart';
import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orange,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("images/logo.png"),
          Loading(),
        ],
      )
    );
  }
}

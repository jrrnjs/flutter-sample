import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/login/login_page.dart';
import 'dart:async';

class Splash extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SplashPage();
  }

}

class SplashPage extends StatefulWidget {

  @override
  State createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    super.initState();
    var duration = Duration(seconds: 2);
    Timer(duration, (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image.asset('assets/bg_splash.png',
            fit: BoxFit.cover,
            width: size.width,
            height: size.height,
          ),
        )
      ],
    );
  }
}

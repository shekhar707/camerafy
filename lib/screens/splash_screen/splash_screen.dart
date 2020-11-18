import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    _navigateTo();
  }

  void _navigateTo() async {
    Future.delayed(Duration(milliseconds: 700), () {
      bool isAuthenticated = true;
      if (isAuthenticated) {
        Navigator.popAndPushNamed(context, '/homeScreen');
      } else {
        // Navigator.popAndPushNamed(context, '/authScreen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FlutterLogo(size: 200,),
              SizedBox(
                height: 30,
              ),
              Text(
                'Camerafy',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}

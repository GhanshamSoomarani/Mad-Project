import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mad/loginform.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 1), // Change the duration to 1.5 seconds
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginForm()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/muet.png',
          width: 200.0,
          height: 200.0,
        ),
      ),
    );
  }
}

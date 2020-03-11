import 'package:flutter/material.dart';
import 'package:patient_care/pages/login_page.dart';
import 'package:splashscreen/splashscreen.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      backgroundColor: Colors.teal[200],
      image: Image.asset('assets/loading.gif'),
      title: new Text('Welcome to \nPatient Care',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
      // loaderColor: Colors.teal,
      photoSize: 150.0,
      navigateAfterSeconds: LoginPage(),
    );
  }
}


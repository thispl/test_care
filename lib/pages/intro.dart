import 'package:flutter/material.dart';
import 'package:patient_care/components/check_network.dart';
import 'package:patient_care/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.getString("cookie") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      backgroundColor: Colors.teal[50],
      image: Image.asset('assets/logo1.png'),
      title: new Text('Welcome to GSPMC',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
      loaderColor: Colors.teal,
      photoSize: 220.0,
      navigateAfterSeconds: CheckNetwork(),
    );
  }
}


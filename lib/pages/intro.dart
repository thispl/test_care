import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:patient_care/components/check_network.dart';
import 'package:splashscreen/splashscreen.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  EncryptedSharedPreferences pref;

  @override
  void initState() {
    super.initState();
    // checkLoginStatus();
  }

  // checkLoginStatus() async {
  //   pref = EncryptedSharedPreferences();
  //   String cookie = await pref.getString("cookie");
  //   if(cookie == null) {
  //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
  //   }
  // }

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




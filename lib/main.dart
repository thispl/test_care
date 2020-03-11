import 'package:flutter/material.dart';
import 'package:patient_care/pages/intro.dart';
import 'package:patient_care/pages/dashboard.dart';
import 'package:patient_care/pages/patient/patient_list.dart';
// import 'package:patient_care/pages/patient/patient_detail.dart';
import 'package:patient_care/pages/research/research_list.dart';
// import 'package:patient_care/pages/research/research_detail.dart';
import 'package:patient_care/pages/kb/kb_list.dart';
// import 'package:patient_care/pages/kb/kb_detail.dart';
import 'package:patient_care/pages/settings.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.teal,
        accentColor: Colors.tealAccent,
        // Define the default font family.
        fontFamily: 'OpenSans',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
  home: IntroPage(),
    );
  }
}


class BtmNavigationBar extends StatefulWidget {
  @override
  _BtmNavigationBarState createState() => _BtmNavigationBarState();
}

class _BtmNavigationBarState extends State<BtmNavigationBar> {
  int _currentIndex = 2;
  final List<Widget> _children = 
  [
    PatientList(),
    ResearchList(),
    MainPage(),
    KBList(),
    Settings()
  ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.teal,
        buttonBackgroundColor: Colors.deepPurple,
        height: 60,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        index: _currentIndex,
        animationCurve: Curves.bounceInOut,
        items: <Widget>[
          Icon(Icons.perm_identity, size: 30, color: Colors.white),
          Icon(Icons.verified_user, size: 30, color: Colors.white),
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.chrome_reader_mode, size: 30, color: Colors.white),
          Icon(Icons.menu, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          onTappedBar(index);
          //Handle button tap
        },
      ),
    );
  }
}





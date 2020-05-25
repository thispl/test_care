import 'package:flutter/material.dart';
import 'package:patient_care/pages/patient/patient_list.dart';
// import 'package:patient_care/pages/patient/patient_detail.dart';
import 'package:patient_care/pages/research/research_list.dart';
// import 'package:patient_care/pages/research/research_detail.dart';
import 'package:patient_care/pages/kb/kb_list.dart';
// import 'package:patient_care/pages/kb/kb_detail.dart';
import 'package:patient_care/pages/settings.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
    // Dashboard(),
    // KBList(),
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
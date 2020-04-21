import 'package:flutter/material.dart';
import 'package:patient_care/pages/intro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


void main() => runApp(GSPMCApp());

class GSPMCApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _GSPMCAppState createState() => _GSPMCAppState();
}

class _GSPMCAppState extends State<GSPMCApp> {
  String notifycontent;

  @override
  void initState() {
    super.initState();
  }

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
        // textTheme: TextTheme(
        //   headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),
        textTheme: GoogleFonts.baskervvilleTextTheme(
      Theme.of(context).textTheme,
    ),
      ),
  home: IntroPage(),
  // home: ExampleApp(),
    );
  }
}

void configOneSignal() {
  //subscribe for Push Notifications
 OneSignal.shared.init('1e134360-7b06-473f-8ffc-3f2b6364965a');
}

// class BtmNavigationBar extends StatefulWidget {
//   @override
//   _BtmNavigationBarState createState() => _BtmNavigationBarState();
// }

// class _BtmNavigationBarState extends State<BtmNavigationBar> {
//   int _currentIndex = 2;
//   final List<Widget> _children = 
//   [
//     PatientList(),
//     ResearchList(),
//     ModulesMenu(),
//     KBTopics(),
//     Settings()
//   ];

//   void onTappedBar(int index){
//     setState(() {
//       _currentIndex = index;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: _children[_currentIndex],
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.white,
//         color: Colors.teal,
//         buttonBackgroundColor: Colors.deepPurple,
//         height: 60,
//         animationDuration: Duration(
//           milliseconds: 200,
//         ),
//         index: _currentIndex,
//         animationCurve: Curves.bounceInOut,
//         items: <Widget>[
//           Icon(Icons.perm_identity, size: 30, color: Colors.white),
//           Icon(Icons.verified_user, size: 30, color: Colors.white),
//           Icon(Icons.home, size: 30, color: Colors.white),
//           Icon(Icons.chrome_reader_mode, size: 30, color: Colors.white),
//           Icon(Icons.menu, size: 30, color: Colors.white),
//         ],
//         onTap: (index) {
//           onTappedBar(index);
//           //Handle button tap
//         },
//       ),
//     );
//   }
// }





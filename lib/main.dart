import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_care/pages/intro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:renovation_core/core.dart';



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
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.teal,
        accentColor: Colors.tealAccent,
        // Define the default font family.
        fontFamily: 'Helevetica',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        // textTheme: TextTheme(
        //   headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),
        textTheme: 
        // GoogleFonts.baskervvilleTextTheme(
      Theme.of(context).textTheme,
    // ),
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

// void configFrappe() async {
//   final frappeInstance = Renovation();
//   await frappeInstance.init('https://mcw-gspmc.tk');
// }





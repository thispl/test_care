import 'package:flutter/material.dart';
import 'package:patient_care/pages/login_page.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:patient_care/components/no_connectivity.dart';


final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

class CheckNetwork extends StatefulWidget {
  @override
  _CheckNetworkState createState() => _CheckNetworkState();
}

class _CheckNetworkState extends State<CheckNetwork> {
  StreamSubscription connectivitySubscription;
  ConnectivityResult _previousResult;

  @override
  void initState() {
    super.initState();

    connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        nav.currentState.push(MaterialPageRoute(
          builder: (BuildContext _) => NoConnectivity()
        ));
      }
      else if (_previousResult == ConnectivityResult.none){
        nav.currentState.push(MaterialPageRoute(
            builder: (BuildContext _) => LoginPage()
        ));
      }

      _previousResult = connectivityResult;
    });
  }

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: nav,
      title: 'My App',
      home: LoginPage(),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {

//     return SplashScreen(
//       seconds: 10,
//       backgroundColor: Colors.teal[200],
//       image: Image.asset('assets/loading.gif'),
//       title: new Text('Welcome to \nPatient Care',
//       style: new TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 20.0
//       ),),
//       loaderColor: Colors.teal,
//       photoSize: 150.0,
//       navigateAfterSeconds: LoginPage(),
//     );
//   }
// }


import 'package:flutter/material.dart';


class PatientDetail extends StatefulWidget {
  @override
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // elevation: 2.0,
          backgroundColor: Colors.teal,
          title: Text('Patient Detail',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0)),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            
          ]),
    );
  }
}

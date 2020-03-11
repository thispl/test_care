import 'package:flutter/material.dart';


class ResearchDetail extends StatefulWidget {
  @override
  _ResearchDetailState createState() => _ResearchDetailState();
}

class _ResearchDetailState extends State<ResearchDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // elevation: 2.0,
          backgroundColor: Colors.teal,
          title: Text('Research Detail',
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

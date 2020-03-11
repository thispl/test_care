import 'package:flutter/material.dart';

class KBList extends StatefulWidget {
  @override
  _KBListState createState() => _KBListState();
}

class _KBListState extends State<KBList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // elevation: 2.0,
          backgroundColor: Colors.teal,
          title: Text('Knowledge Base',
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



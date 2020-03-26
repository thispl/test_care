import 'package:flutter/material.dart';
import 'package:patient_care/models/knowledgebase/article.dart';
import 'package:patient_care/pages/modules_menu.dart';

import 'kb_list.dart';
class KBDetail extends StatelessWidget {
  // static final String path = "lib/src/pages/profile/profile2.dart";
  final Article article;
  KBDetail({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => KBList()));
              },
            ),
          title: Text('KB Info',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0)),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ModulesMenu()));
              },
            ),
          ]),
      body: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal.shade300, Colors.teal.shade500]),
            ),
          ),
        ],
      ),
    );
  }
}
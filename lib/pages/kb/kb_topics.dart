import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:patient_care/pages/kb/kb_list.dart';
import 'package:patient_care/pages/modules_menu.dart';

class KBTopics extends StatelessWidget {
  KBTopics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // elevation: 2.0,
          backgroundColor: Colors.teal,
          leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ModulesMenu()));
              },
            ),
          title: Text('Knowledge Base',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0)),
          actions: <Widget>[
            // action button
            
            
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            children: <Widget>[
              Expanded(
                child: 
                CupertinoButton(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/kbtopics/bio-informatics.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                    child: Text(
                      "BioInformatics",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => KBList()));
                },
              ),
              ),
              
              Expanded(
                child: 
                CupertinoButton(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/kbtopics/neurogenomics.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                    child: Text(
                      "Neurogenomics",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                onPressed: () {
                },
              ),
              )
            ],
          ),
        ),

      ),

    );
  }
}
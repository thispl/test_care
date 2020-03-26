import 'package:flutter/material.dart';
import 'package:patient_care/components/grid_dashboard.dart';
import 'package:patient_care/pages/settings.dart';

class ModulesMenu extends StatefulWidget {
  @override
  _ModulesMenuState createState() => _ModulesMenuState();
}

class _ModulesMenuState extends State<ModulesMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          leading: Icon(Icons.home),
          title: Text("John Doe's Modules"),
          backgroundColor: Colors.teal,
        ),
      ),
      backgroundColor: Colors.black,
      body: GridDashboard(),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 50.0, bottom: 20.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Settings()));
            },
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Icon(
                Icons.settings,
                color: Colors.white,
                size: 50.0,
              ),
            ),
          )
          ),
    );
  }
}

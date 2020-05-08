import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:patient_care/components/grid_menu.dart';
import 'package:patient_care/pages/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

// class ModulesMenu extends StatefulWidget {
//   @override
//   _ModulesMenuState createState() => _ModulesMenuState();
// }

class ModulesMenu extends StatefulWidget {
  @override
  _ModulesMenuState createState() => _ModulesMenuState();
}

class _ModulesMenuState extends State<ModulesMenu> {
  EncryptedSharedPreferences pref;
  String username;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    pref = EncryptedSharedPreferences();
    String user = await pref.getString('username');
    if (user != null) {
      setState(() {
        username = user;
      });
    }
  }

  Future<String> user = getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                  colors: [
                    Colors.teal.shade500,
                    Colors.teal.shade200,
                  ])),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.home,
                    size: 32.0,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      "$username's Modules",
                      style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 28.0),
                    ),
                  ),
                ],
              ),
            )),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(child: GridMenu()),
      floatingActionButton: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Settings()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, bottom: 20.0),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                  alignment: Alignment.bottomRight,
                  child: Image.asset('assets/logo.png')),
            ),
          ),
        ],
      ),
    );
  }
}

Future<String> getUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String cookie = pref.getString('cookie');
  return 'Admin';
}

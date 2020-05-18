import 'dart:ui';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:patient_care/models/license_info.dart';
import 'package:patient_care/services/settings-api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_html/flutter_html.dart';
import 'login_page.dart';
import 'modules_menu.dart';
import 'package:patient_care/utilities/utils.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  EncryptedSharedPreferences pref;
  String username;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    getUserInfo();
  }

  checkLoginStatus() async {
    pref = EncryptedSharedPreferences();
    String cookies = await pref.getString('cookie');
    if (cookies == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        ModalRoute.withName('/'),
      );
    }
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

  @override
  Widget build(BuildContext context) {
    // getCookieValue('full_name');

    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              title: Text("Settings"),
              backgroundColor: Colors.teal,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ModulesMenu()));
                },
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    pref.clear().then((value) {
                    });
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                      ModalRoute.withName('/'),
                    );
                  },
                )
              ],
            ),
            body: Stack(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                  Colors.teal.shade100,
                  Colors.teal.shade200,
                  Colors.teal.shade300,
                  Colors.teal.shade400
                ]))),
                Positioned(
                  top: 50.0,
                  left: 50.0,
                  child: Text(
                    '$username',
                    style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 36.0),
                  ),
                ),
              ],
            )),
        Container(
          child: FutureBuilder(
              future: fetchLicenseInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  if (snapshot.hasError) {
                    Alert(
                            context: context,
                            title: "Connection Failed",
                            desc: snapshot.data)
                        .show();
                  }
                  return listViewWidget(snapshot.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    );
  }
}

Container listViewWidget(List<LicenseInfo> licenseInfo) {
  return licenseInfo.length <= 0
      ? Container(
          // child: Center(
          //     child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(Icons.announcement),
          //     Text('No Data Found'),
          //   ],
          // )),
        )
      : Container(
          padding: EdgeInsets.only(
              top: 250.0, left: 10.0, right: 10.0, bottom: 50.0),
          child: Material(
              elevation: 5.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: ListView.builder(
                      itemCount: licenseInfo.length,
                      padding: const EdgeInsets.all(2.0),
                      itemBuilder: (context, position) {
                        return ListTile(
                          title: Text(
                            '${licenseInfo[position].title ?? ''}',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () =>
                              _onTapItem(context, licenseInfo[position]),
                        );
                      }),
                ),
              )),
        );
}

void _onTapItem(BuildContext context, LicenseInfo licenseInfo) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text(licenseInfo.title),
        content: Container(
            child: SingleChildScrollView(
                child: Html(data: licenseInfo.description ?? ''))),
        actions: <Widget>[
          FlatButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

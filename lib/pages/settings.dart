import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient_care/models/license_info.dart';
import 'package:patient_care/services/settings-api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_html/flutter_html.dart';

import 'modules_menu.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
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
              actions: <Widget>[Icon(Icons.exit_to_app)],
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(height: 200.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/settings.jpg'),
                    fit: BoxFit.cover,
                    // colorFilter: ColorFilter.mode(
                    //     Colors.white.withOpacity(0.3), BlendMode.dstATop),
                  )),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.0),
                      child: Center(
                        child: Text(
                          'John Doe',
                          style: GoogleFonts.baskervville(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 48.0),
                          ),
                        ),
                      ),
                    ),
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
  return Container(
    padding: EdgeInsets.only(top: 250.0, left: 10.0, right: 10.0, bottom: 50.0),
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
                      style: GoogleFonts.baskervville(
                        textStyle: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () => _onTapItem(context, licenseInfo[position]),
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

import 'dart:ui';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

setCookieVariables() {
  setUsername();
  setUserid();
}

setUsername() async {
  String fieldname = 'full_name';
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  RegExp exp = new RegExp(('(^|[^;]+)\\s*' + fieldname + '\\s*=\\s*([^;]+)'));
  Iterable<Match> matches = exp.allMatches(cookie);
  for (Match m in matches) {
    String match = m.group(0);
    List cookieArr = match.split(',');
    for (var i = 0; i < cookieArr.length; i++) {
      var cookiePair = cookieArr[i].split("=");
      if (fieldname == cookiePair[0].trim()) {
        // Decode the cookie value and return
        String value = Uri.decodeComponent(cookiePair[1]);
        pref.setString('username', value).then((bool success) {
          if (success) {
            print(value);
          } else {
            print('Error');
          }
        });
      }
    }
  }
}

setUserid() async {
  String fieldname = 'user_id';
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  RegExp exp = new RegExp(('(^|[^;]+)\\s*' + fieldname + '\\s*=\\s*([^;]+)'));
  Iterable<Match> matches = exp.allMatches(cookie);
  for (Match m in matches) {
    String match = m.group(0);
    List cookieArr = match.split(',');
    for (var i = 0; i < cookieArr.length; i++) {
      var cookiePair = cookieArr[i].split("=");
      if (fieldname == cookiePair[0].trim()) {
        // Decode the cookie value and return
        String value = Uri.decodeComponent(cookiePair[1]);
        pref.setString('user_id', value).then((bool success) {
          if (success) {
            print(value);
          } else {
            print('Error');
          }
        });
      }
    }
  }
}

void showAlert(context, title, body) {
  // flutter defined function
  showCupertinoDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: CupertinoAlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    },
  );
}

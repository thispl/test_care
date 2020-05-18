import 'dart:convert';

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.teal,
            title: Text('Reset Password',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0)),
            actions: <Widget>[
              // action button
            ]),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                    controller: emailcontroller,
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                      hintText: 'Enter Your Email',
                    )),
              ),
              Builder(
                builder: (context) => RaisedButton(
                  onPressed: () {
                    sendResetMail(emailcontroller.text).then((result) {
                      Widget content = Text('Password Reset Mail Sent !!');
                      if (_formKey.currentState.validate()) {
                        if (result == 'Not Exists') {
                          content = Text('User Not Found !!');
                        }
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: content,
                        ));
                      }
                    });
                  },
                  child: Text('Send Password Reset Mail'),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                      (Route<dynamic> route) => false);
                },
                child: Text('Back to Login'),
              ),
            ],
          ),
        ));
  }
}

TextEditingController emailcontroller = new TextEditingController();

sendResetMail(String email) async {
  var url =
      'https://mcw-gspmc.tk/api/method/frappe.core.doctype.user.user.reset_password';
  Map data = {'user': email};

  Map<String, String> requestHeaders = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json'
  };
  var response = await http.post(url, body: data, headers: requestHeaders);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    String message = jsonData['message'];
    if (message == 'not found') {
      return 'Not Exists';
    }
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

// Widget _showSnackBar(BuildContext context) {
//   return SnackBar(content: Text('Processing Data'));
// }

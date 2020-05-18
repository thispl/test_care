import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_care/pages/password_reset.dart';
import 'package:patient_care/services/login-api.dart';
import 'package:patient_care/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:patient_care/utilities/utils.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:patient_care/pages/modules_menu.dart';

class CheckAgreement extends StatefulWidget {
  @override
  _CheckAgreementState createState() => _CheckAgreementState();
}

class _CheckAgreementState extends State<CheckAgreement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.teal[100],
                  Colors.teal[200],
                  Colors.teal[300],
                  Colors.teal[400],
                  Colors.teal
                ],
              )),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      Text(
                        'Welcome to MCW-GSPMC',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Opensans',
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        'Kindly Enter the New Password to Continue Logging In',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Opensans',
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      _passwordTF(),
                      SizedBox(height: 30.0),
                      _confirmPasswordTF(),
                      _agreedCheck(),
                      _submit(context)
                    ],
                  )),
            )
          ]),
        ),
      ),
    );
  }

  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController confirmpasswordcontroller = new TextEditingController();

  Widget _passwordTF() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'New Password',
            style: kLabelStyleBlack,
          ),
          SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextField(
                  obscureText: true,
                  controller: passwordcontroller,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    hintText: 'Enter New Password',
                    hintStyle: kHintTextStyleBlack,
                  )))
        ]);
  }

  Widget _confirmPasswordTF() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Re-Enter to Confirm',
            style: kLabelStyleBlack,
          ),
          SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextField(
                  obscureText: true,
                  controller: confirmpasswordcontroller,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                    hintText: 'Re-Enter New Password',
                    hintStyle: kHintTextStyleBlack,
                  )))
        ]);
  }

  Widget _agreedCheck() {
    bool _isAgreed = true;
    return Row(
      children: [
        Checkbox(
          value: _isAgreed,
          onChanged: (bool newValue) {
            setState(() {
              _isAgreed = newValue;
            });
          },
        ),
        Text(
          'I agree to all the ',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        Text(
          'Terms & Conditions',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
        )
      ],
    );
  }

  Widget _submit(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 25.0),
        child: RaisedButton(
            elevation: 5.0,
            onPressed: () {
              _submitPassword(passwordcontroller.text);
            },
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.white,
            child: Text(
              'SUBMIT',
              style: TextStyle(
                  color: Colors.teal,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
            )));
  }

  _submitPassword(password) async {
    int status = await submitAgreement(password);
    String alert_title = 'Ok';
    String alert_desc = 'Agreed';

    if (status == 403) {
      alert_title = "Not Permitted";
      alert_desc = "User is not Permitted";
    }
    if (status == 417) {
      alert_title = "Weak Password";
      alert_desc = "Try a Strong Password by including Alphanumeric-special characters";
    }
    if (status == 404) {
      alert_title = "Not Found";
      alert_desc = "User Not Found";
    }
    Alert(
      context: context,
      type: AlertType.error,
      title: alert_title,
      desc: alert_desc,
      buttons: [
        DialogButton(
          child: Text(
            "Retry",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          width: 120,
        )
      ],
    ).show();
  }
}

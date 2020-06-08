import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_care/pages/check_agreement.dart';
import 'package:patient_care/pages/password_reset.dart';
import 'package:patient_care/services/login-api.dart';
import 'package:patient_care/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:patient_care/utilities/utils.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:patient_care/pages/modules_menu.dart';

class User {
  String userid;
  User({this.userid});
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

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
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Opensans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      _emailTF(),
                      SizedBox(height: 30.0),
                      _passwordTF(),
                      _forgetPasswordBtn(),
                      _loginBtn(context)
                    ],
                  )),
            )
          ]),
        ),
      ),
    );
  }

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  signin(String email, String password) async {
    var url = 'https://www.mcw-gspmc.tk/api/method/login';
    Map data = {'usr': email, 'pwd': password};

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };

    var jsonData;
    EncryptedSharedPreferences pref = EncryptedSharedPreferences();
    var response = await http.post(url, body: data, headers: requestHeaders);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);

      setState(() {
        _isLoading = false;
        response.headers.forEach((key, value) {
          if (key == 'set-cookie') {
            pref.setString('cookie', value).then((bool success) {
              if (success) {
                print('cookie is set');
                setCookieVariables();
              } else {
                print('Error');
              }
            });
          }
        });
        Future.delayed(const Duration(seconds: 1), () {
          navigateToHome();
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(
          //       builder: (BuildContext context) => ModulesMenu(),
          //     ),
          //     (Route<dynamic> route) => false);
        });
      });
    } else {
      if (response.statusCode == 401) {
        showAlert(context, "Authentication Failed", "Check Username/Password");
      }
    }
  }

  navigateToHome() {
    checkAgreed().then((value) {
      if (value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => ModulesMenu(),
            ),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => CheckAgreement(),
            ),
            (Route<dynamic> route) => false);
      }
    });
  }

  Widget _emailTF() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 60.0,
              child: TextField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    hintText: 'Enter Your Email',
                    hintStyle: kHintTextStyle,
                  )))
        ]);
  }

  Widget _passwordTF() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Password',
            style: kLabelStyle,
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
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    hintText: 'Enter Your Password',
                    hintStyle: kHintTextStyle,
                  )))
        ]);
  }

  Widget _forgetPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => PasswordReset(),
              ),
              (Route<dynamic> route) => false);
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text('Forgot Password?', style: kLabelStyle),
      ),
    );
  }

  Widget _loginBtn(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 25.0),
        child: RaisedButton(
            elevation: 5.0,
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              signin(emailcontroller.text, passwordcontroller.text);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => BtmNavigationBar()),
              // );
            },
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.white,
            child: Text(
              'LOGIN',
              style: TextStyle(
                  color: Colors.teal,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_care/main.dart';
import 'package:patient_care/utilities/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
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
      onPressed: () => print('Forgot Password Button Pressed'),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BtmNavigationBar()),
            );
          },
          padding: EdgeInsets.all(15.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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

class _LoginPageState extends State<LoginPage> {
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
}

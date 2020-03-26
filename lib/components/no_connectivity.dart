import 'package:flutter/material.dart';

 
 class NoConnectivity extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
          title: Text('Connectivity Issue',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0)),
          actions: <Widget>[
            // action button
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child:Image(image:AssetImage('assets/offline.png')),  
     ),
          ));
     
    
   }
 }
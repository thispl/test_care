import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          shape: PolygonBorder(sides: 5),
          child: Icon(Icons.star),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: AutomaticNotchedShape(
              RoundedRectangleBorder(), PolygonBorder(sides: 5)),
          color: Colors.blue.shade100,
          notchMargin: 6.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text("Action 1"),
                onPressed: () => {},
              ),
              FlatButton(
                child: Text("Action 2"),
                onPressed: () => {},
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ClipPolygon(
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Container(
                          child: Center(
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 50.0,
                              textDirection: TextDirection.ltr,
                            ),
                          )),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                          color: Colors.black,
                          child: Center(
                            child: Text(
                              "Patients",
                              style: TextStyle(
                                fontSize:14.0,
                                fontWeight:FontWeight.bold,
                                color:Colors.white
                              ),
                            )
                          )),
                    ),
                  ],
                ),
                boxShadows: [
                  PolygonBoxShadow(color: Colors.black, elevation: 5.0),
                ],
                sides: 8,
                rotate: 20.0,
                borderRadius: 5.0,
              ),
              SizedBox(
                height: 32.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(18.0),
                      margin: EdgeInsets.only(right: 16.0),
                      decoration: ShapeDecoration(
                          shape: PolygonBorder(
                              sides: 8,
                              borderRadius: 6.0,
                              rotate: 20.0,
                              border: BorderSide(
                                  color: Colors.blue.shade800, width: 3))),
                      child: Text('8'),
                    ),
                    Text('This decoration has seven sides.')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

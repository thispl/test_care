import 'package:flutter/material.dart';
import 'package:patient_care/models/patient.dart';
import 'package:patient_care/pages/modules_menu.dart';
import 'package:patient_care/pages/patient/patient_list.dart';
import 'package:patient_care/services/patient-api.dart';

class PatientDetail extends StatefulWidget {
  // static final String path = "lib/src/pages/profile/profile2.dart";
  final Patient patient;
  PatientDetail({Key key, @required this.patient}) : super(key: key);
  
  // markRead();

  @override
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {

  @override
  void initState() {
    super.initState();
    markRead(widget.patient.patientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
          leading: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PatientList()));
                  },
                ),
            ],
          ),
          title: Text('Patient Info',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0)),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ModulesMenu()));
              },
            ),
          ]),
      body: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.teal.shade300, Colors.teal.shade500]),
            ),
          ),
          ListView.builder(
            itemCount: 2,
            itemBuilder: _mainListBuilder,
          ),
        ],
      ),
    );
  }

   Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return _buildHeader(context);
    if (index == 1) return _buildRemark(context);
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    '${widget.patient.firstName}',
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Text("In Progress"),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text("Age",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                            subtitle: Text(
                              'age'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("Status",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                            subtitle: Text(
                              '${widget.patient.status}'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("Doctor",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                            subtitle: Text(
                              'doctor'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage('assets/no-image-available.jpg'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Container _buildRemark(context) {
  return Container(
    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
    child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        color: Colors.teal.shade50,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Oct 21, 2017"),
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {},
                    )
                  ],
                ),
                Text(
                  "Lorem ipsum dolor sit amet",
                  style: Theme.of(context).textTheme.headline,
                ),
                Divider(),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aperiam, ullam? Fuga doloremque repellendus aut sequi officiis dignissimos, enim assumenda tenetur reprehenderit quam error, accusamus ipsa? Officiis voluptatum sequi voluptas omnis. Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aperiam, ullam? Fuga doloremque repellendus aut sequi officiis dignissimos, enim assumenda tenetur reprehenderit quam error, accusamus ipsa? Officiis voluptatum sequi voluptas omnis.",
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ]),
        )
        ),
  );
}

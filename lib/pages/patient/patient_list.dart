import 'package:flutter/material.dart';
import 'package:patient_care/pages/patient/patient_detail.dart';
import 'package:patient_care/services/patient-api.dart';
import 'package:patient_care/models/patient.dart';
import '../modules_menu.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Completed',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('In Progress',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            elevation: 2.0,
            backgroundColor: Colors.teal,
            leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ModulesMenu()));
              },
            ),
            title: Text('Patients',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0)),
            actions: <Widget>[
              // action button
            ]),
        body: SafeArea(
          child: TabBarView(children: [
            Container(
              child: FutureBuilder(
                  future: fetchPatient(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return listViewWidget(snapshot.data);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Container(
              child: FutureBuilder(
                  future: fetchPatient(),
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
          ]),
        ),
      ),
    );
  }
}

_isSeen(patient, position) {
  bool seen = true;
//  seen =/ patient[position]?.read ?? true;
//  print(seen);
  return seen;
}

Widget listViewWidget(List<Patient> patient) {
  return Container(
    child: ListView.builder(
        itemCount: patient.length,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return Card(
            color: _isSeen(patient, position) ? Colors.teal : Colors.teal[50],
            child: ListTile(
              title: Text(
                '${patient[position].firstName ?? ''}' +
                    ' ' +
                    '${patient[position].lastName ?? ''}',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${patient[position].conditions}',
                style: TextStyle(
                    // fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'NEW',
                    style: TextStyle(
                        // fontSize: 18.0,
                        color: Colors.teal[200],
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '02-28-2020',
                    style: TextStyle(
                        // fontSize: 18.0,
                        color: Colors.teal[200],
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // leading: patient[position].photo == null
              //     ? Image(
              //         image: AssetImage('assets/no-image-available.jpg'),
              //       )
              //     : Image.network('${patient[position].photo}'),
              onTap: () => _onTapItem(context, patient[position]),
            ),
          );
        }),
  );
}

void _onTapItem(BuildContext context, Patient patient) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PatientDetail(patient: patient)));
}

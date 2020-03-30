import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient_care/pages/patient/patient_detail.dart';
import 'package:patient_care/services/patient-api.dart';
import 'package:patient_care/models/patient.dart';
import '../modules_menu.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  Widget build(BuildContext context) {
    String filter;
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
            title: Text(
              'Patients',
              style: GoogleFonts.baskervville(
                textStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            actions: <Widget>[
              // action button
            ]),
        body: SafeArea(
          child: TabBarView(children: [
            buildCompletedList(filter = '["status", "=", "Reported"]'),
            buildCompletedList(filter = '["status", "=", "In Progress"]'),
          ]),
        ),
      ),
    );
  }

  Container buildInProgressList(String filter) {
    return Container(
      
      child: FutureBuilder(
          future: fetchPatient(filter),
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
    );
  }

  Container buildCompletedList(String filter) {
    _refresh(){
      setState(() {});
    }
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    return Container(
      child: FutureBuilder(
          future: fetchPatient(filter),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              List<Patient> patient = snapshot.data;
              return Container(
                child: LiquidPullToRefresh(
                  color:Colors.teal,
                  key: _refreshIndicatorKey,
                  onRefresh: _refresh,
                  child: ListView.builder(
                      itemCount: patient.length,
                      padding: const EdgeInsets.all(2.0),
                      itemBuilder: (context, position) {
                        return Card(
                          color: _isSeen(patient, position)
                              ? Colors.white
                              : Colors.teal[50],
                          child: ListTile(
                            title: Text(
                              '${patient[position].firstName ?? ''}' +
                                  ' ' +
                                  '${patient[position].lastName ?? ''}',
                              style: GoogleFonts.baskervville(
                                textStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: Text(
                              '${patient[position].conditions}',
                              style: GoogleFonts.playfairDisplay(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  _isSeen(patient, position) ? 'READ' : 'NEW',
                                  style: GoogleFonts.lora(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  '${patient[position].reportDate}',
                                  style: GoogleFonts.lora(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () => _onTapItem(context, patient[position]),
                          ),
                        );
                      }),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

_isSeen(patient, position) {
  bool seen = false;
  if (patient[position].read != null) {
    seen = true;
  }
  return seen;
}


// Widget listViewWidget(List<Patient> patient) {
  
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();
//   return Container(
//     child: ListView.builder(
//         itemCount: patient.length,
//         padding: const EdgeInsets.all(2.0),
//         itemBuilder: (context, position) {
//           return Card(
//             color:
//                 _isSeen(patient, position) ? Colors.white : Colors.teal[50],
//             child: ListTile(
//               title: Text(
//                 '${patient[position].firstName ?? ''}' +
//                     ' ' +
//                     '${patient[position].lastName ?? ''}',
//                 style: GoogleFonts.baskervville(
//                   textStyle: TextStyle(
//                       fontSize: 18.0,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               subtitle: Text(
//                 '${patient[position].conditions}',
//                 style: GoogleFonts.playfairDisplay(
//                   textStyle: TextStyle(
//                     color: Colors.black,
//                     // fontWeight: FontWeight.bold
//                   ),
//                 ),
//               ),
//               trailing: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     _isSeen(patient, position) ? 'READ' : 'NEW',
//                     style: GoogleFonts.lora(
//                       textStyle: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Text(
//                     '${patient[position].reportDate}',
//                     style: GoogleFonts.lora(
//                       textStyle: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//               onTap: () => _onTapItem(context, patient[position]),
//             ),
//           );
//         }),
//   );
// }

void _onTapItem(BuildContext context, Patient patient) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PatientDetail(patient: patient)));
}
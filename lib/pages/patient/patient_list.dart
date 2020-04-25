import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient_care/components/constants.dart';
import 'package:patient_care/pages/patient/patient_detail.dart';
import 'package:patient_care/pages/patient/pdf_service.dart';
import 'package:patient_care/services/patient-api.dart';
import 'package:patient_care/models/patient.dart';
import '../modules_menu.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:badges/badges.dart';
import 'package:patient_care/components/utils.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList>
    with SingleTickerProviderStateMixin {
  int count;
  String filter;

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 5.0,
                      shape: CircleBorder(),
                      color: Colors.teal.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text('12',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('New',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 5.0,
                      shape: CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text('12',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('Read',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 5.0,
                      shape: CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text('12',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text('In Progress',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(color: Colors.teal),
            child: TabBar(
              controller: _controller,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text('Completed',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ),
                Tab(
                  child: Text('In Progress',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ),
              ],
            ),
          ),
          Container(
            height: 1000.0,
            child: TabBarView(controller: _controller, children: [
              buildCompletedList(filter = '["status", "=", "Reported"]'),
              buildPendingList(filter = '["status", "=", "In Progress"]'),
            ]),
          )
        ],
      )),
    );
  }

  Container buildCompletedList(String filter) {
    _refresh() {
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
              if (snapshot.hasError) {
                Alert(
                        context: context,
                        title: "Connection Failed",
                        desc: snapshot.data)
                    .show();
              }
              List<Patient> patient = snapshot.data;
              return Container(
                child: LiquidPullToRefresh(
                  color: Colors.teal,
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
                              '${patient[position].patientId}',
                              style: GoogleFonts.playfairDisplay(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      _isSeen(patient, position)
                                          ? 'READ'
                                          : 'NEW',
                                      style: GoogleFonts.lora(
                                        textStyle: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      getFormatted(
                                          '${patient[position].reportDate}'),
                                      style: GoogleFonts.lora(
                                        textStyle: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    PopupMenuButton<String>(
                                        onSelected: (value) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PDFService(patient[position]
                                                      .report)));
                                    }, itemBuilder: (BuildContext context) {
                                      return Constants.choices
                                          .map((String choice) {
                                        return PopupMenuItem<String>(
                                            value: choice,
                                            child: Text('Show Report'));
                                      }).toList();
                                    }),
                                  ],
                                )
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

  void choiceAction(String value) {
    print(value);
  }

  Container buildPendingList(String filter) {
    _refresh() {
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
              if (snapshot.hasError) {
                Alert(
                        context: context,
                        title: "Connection Failed",
                        desc: snapshot.data)
                    .show();
              }
              List<Patient> patient = snapshot.data;
              return Container(
                child: LiquidPullToRefresh(
                  color: Colors.teal,
                  key: _refreshIndicatorKey,
                  onRefresh: _refresh,
                  child: ListView.builder(
                      itemCount: patient.length,
                      padding: const EdgeInsets.all(2.0),
                      itemBuilder: (context, position) {
                        return Card(
                          color: Colors.white,
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
                              '${patient[position].patientId}',
                              style: GoogleFonts.playfairDisplay(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'In Progress',
                                  style: GoogleFonts.lora(
                                    textStyle: TextStyle(
                                        color: Colors.grey,
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
  if (patient[position].read == 1) {
    seen = true;
  }
  return seen;
}

void _onTapItem(BuildContext context, Patient patient) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PatientDetail(patient: patient)));
}

// Badge(
//   badgeColor: Colors.white,
//   shape: BadgeShape.circle,
//   borderRadius: 25,
//   toAnimate: false,
//   badgeContent: Text(count.toString(),
//       style: TextStyle(color: Colors.black)),
// ),
// ],

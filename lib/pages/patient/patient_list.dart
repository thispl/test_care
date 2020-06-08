import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:patient_care/utilities/constants.dart';
import 'package:patient_care/pages/patient/patient_detail.dart';
import 'package:patient_care/pages/patient/pdf_service.dart';
import 'package:patient_care/services/patient-api.dart';
import 'package:patient_care/models/patient.dart';
import '../modules_menu.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:badges/badges.dart';
import 'package:patient_care/components/utils.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  String pendingCount;
  String completedCount;
  String filter;

  List<Patient> completedPatients = List();
  List<Patient> filteredCompletedPatients = List();
  List<Patient> pendingPatients = List();
  List<Patient> filteredPendingPatients = List();

  bool error = false;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadList();
  }

  loadList() {
    fetchCompletedPatient().then((completedPatientFromServer) {
      setState(() {
        isLoading = false;
        completedPatients = completedPatientFromServer;
        filteredCompletedPatients = completedPatients;
        completedCount = (filteredCompletedPatients.length).toString();
      });
    }).catchError((e) {
      setState(() {
        error = true;
      });
    });

    fetchPendingPatient().then((pendingPatientFromServer) {
      setState(() {
        isLoading = false;
        pendingPatients = pendingPatientFromServer;
        filteredPendingPatients = pendingPatients;
        pendingCount = (filteredPendingPatients.length).toString();
      });
    }).catchError((e) {
      setState(() {
        error = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Completed',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)),
                    ),
                    Badge(
                      badgeColor: Colors.white,
                      shape: BadgeShape.circle,
                      borderRadius: 50,
                      toAnimate: false,
                      badgeContent: Text(completedCount ?? '',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('In Progress',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)),
                    ),
                    Badge(
                      badgeColor: Colors.white,
                      shape: BadgeShape.circle,
                      borderRadius: 25,
                      toAnimate: false,
                      badgeContent: Text(pendingCount ?? '',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                )
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
                    color: Colors.white, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              // action button
            ]),
        body: SafeArea(
          child: TabBarView(children: [
            buildCompletedList(filter = '["status", "=", "Reported"]'),
            buildPendingList(filter = '["status", "=", "In Progress"]'),
          ]),
        ),
      ),
    );
  }

  Container buildCompletedList(String filter) {
    _refresh() {
      setState(() {
        loadList();
      });
    }

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    return Container(
      child: isLoading
          ? CardListSkeleton(
                style: SkeletonStyle(
                  theme: SkeletonTheme.Light,
                  isShowAvatar: true,
                  isCircleAvatar: true,
                  barCount: 2,
                ),
              )
          : Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Enter Patient Name or ID',
                  ),
                  onChanged: (string) {
                    setState(() {
                      filteredCompletedPatients = completedPatients
                          .where((a) =>
                              a.firstName
                                  .toLowerCase()
                                  .contains(string.toLowerCase()) ||
                              a.patientId
                                  .toLowerCase()
                                  .contains(string.toLowerCase()))
                          .toList();
                    });
                  },
                ),
                Expanded(
                  child: Container(
                    child: LiquidPullToRefresh(
                      color: Colors.teal,
                      key: _refreshIndicatorKey,
                      onRefresh: _refresh,
                      child: ListView.builder(
                          itemCount: filteredCompletedPatients.length,
                          padding: const EdgeInsets.all(2.0),
                          itemBuilder: (context, position) {
                            return Card(
                              color:
                                  _isSeen(filteredCompletedPatients, position)
                                      ? Colors.white
                                      : Colors.teal[50],
                              child: ListTile(
                                title: Text(
                                    '${filteredCompletedPatients[position].firstName ?? ''}' +
                                        ' ' +
                                        '${filteredCompletedPatients[position].lastName ?? ''}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                  '${filteredCompletedPatients[position].patientId}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            _isSeen(filteredCompletedPatients,
                                                    position)
                                                ? 'READ'
                                                : 'NEW',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            getFormatted(
                                                '${filteredCompletedPatients[position].reportDate}'),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    filteredCompletedPatients[position]
                                                .report !=
                                            null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              PopupMenuButton<String>(
                                                  onSelected: (value) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            PDFService(
                                                                filteredCompletedPatients[
                                                                        position]
                                                                    .report)));
                                              }, itemBuilder:
                                                      (BuildContext context) {
                                                return Constants.choices
                                                    .map((String choice) {
                                                  return PopupMenuItem<String>(
                                                      value: choice,
                                                      child:
                                                          Text('Show Report'));
                                                }).toList();
                                              }),
                                            ],
                                          )
                                        : Container()
                                  ],
                                ),
                                onTap: () => _onTapItem(context,
                                    filteredCompletedPatients[position]),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Container buildPendingList(String filter) {
    _refresh() {
      setState(() {
        loadList();
      });
    }

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    return Container(
      child: isLoading
          ? CardListSkeleton(
                style: SkeletonStyle(
                  theme: SkeletonTheme.Light,
                  isShowAvatar: true,
                  isCircleAvatar: true,
                  barCount: 2,
                ),
              )
          : Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Enter Patient Name or ID',
                  ),
                  onChanged: (string) {
                    setState(() {
                      filteredPendingPatients = pendingPatients
                          .where((a) =>
                              a.firstName
                                  .toLowerCase()
                                  .contains(string.toLowerCase()) ||
                              a.patientId
                                  .toLowerCase()
                                  .contains(string.toLowerCase()))
                          .toList();
                    });
                  },
                ),
                Expanded(
                  child: Container(
                    child: LiquidPullToRefresh(
                      color: Colors.teal,
                      key: _refreshIndicatorKey,
                      onRefresh: _refresh,
                      child: ListView.builder(
                          itemCount: filteredPendingPatients.length,
                          padding: const EdgeInsets.all(2.0),
                          itemBuilder: (context, position) {
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                    '${filteredPendingPatients[position].firstName ?? ''}' +
                                        ' ' +
                                        '${filteredPendingPatients[position].lastName ?? ''}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                  '${filteredPendingPatients[position].patientId}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('In Progress',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                onTap: () => _onTapItem(
                                    context, filteredPendingPatients[position]),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

_isSeen(patient, position) {
  bool seen = false;
  if (patient[position].read == "1") {
    seen = true;
  }
  return seen;
}

void _onTapItem(BuildContext context, Patient patient) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PatientDetail(patient: patient)));
}

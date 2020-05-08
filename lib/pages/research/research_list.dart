import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:patient_care/models/research.dart';
import 'package:patient_care/pages/research/research_detail.dart';
import 'package:patient_care/services/research-api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../modules_menu.dart';

class ResearchList extends StatefulWidget {
  @override
  _ResearchListState createState() => _ResearchListState();
}

class _ResearchListState extends State<ResearchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // elevation: 2.0,
        backgroundColor: Colors.teal,
        title: Text('Research',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20.0)),

        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ModulesMenu()));
          },
        ),
      ),
      body: SafeArea(
        child: buildContainer(),
      ),
    );
  }

  Container buildContainer() {
    _refresh() {
      setState(() {});
    }

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    return Container(
      child: FutureBuilder(
          future: fetchResearch(),
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
              List<Research> research = snapshot.data;
              return research.length <= 0
                  ? Container(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.announcement),
                          Text('No Data Found'),
                        ],
                      )),
                    )
                  : Container(
                      child: LiquidPullToRefresh(
                          color: Colors.teal,
                          key: _refreshIndicatorKey,
                          onRefresh: _refresh,
                          child: ListView.builder(
                              itemCount: research.length,
                              padding: const EdgeInsets.all(2.0),
                              itemBuilder: (context, position) {
                                return _buildList(research, position);
                              })),
                    );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Padding _buildList(List<Research> research, int position) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        child: Material(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(10.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Project', style: TextStyle(color: Colors.grey)),
                      SizedBox(
                        width: 120.0,
                        child: Text(
                          '${research[position].projectName ?? ''}',
                          style: GoogleFonts.baskervville(
                            textStyle: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          softWrap: true,
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Status', style: TextStyle(color: Colors.grey)),
                      Text('${research[position].status ?? ''}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0))
                    ],
                  ),
                  Material(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(1.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            '${research[position].percentOfCompletion ?? ''}' +
                                '%',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 32.0)),
                      )))
                ]),
          ),
        ),
      ),
    );
  }

  Card buildList(List<Research> research, int position) {
    return Card(
        color: Colors.white,
        child: ListTile(
            title: Text(
              '${research[position].projectName ?? ''}',
              style: GoogleFonts.baskervville(
                textStyle: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Text(
              '${research[position].projectId ?? ''}',
              style: GoogleFonts.baskervville(
                textStyle: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '12%',
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            onTap: () {}));
  }
}

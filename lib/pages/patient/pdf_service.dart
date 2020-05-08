import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:patient_care/pages/patient/patient_list.dart';

class PDFService extends StatefulWidget {
  final String reportPath;
  PDFService(this.reportPath);
  @override
  _PDFServiceState createState() => _PDFServiceState();
}

class _PDFServiceState extends State<PDFService> {
  String report;
  String url;
  PDFDocument _doc;
  bool _loading;

  @override
  void initState() {
    report = widget.reportPath;
    url = 'https://mcw-gspmc.tk' + report;
    super.initState();
    _initPdf();
  }

  _initPdf() async {
    setState(() {
      _loading = true;
    });
    EncryptedSharedPreferences pref = await EncryptedSharedPreferences();
    String cookie = await pref.getString('cookie');
    Map<String,String> requestHeaders = {
       'Accept': 'application/json',
       'Cookie': cookie
     };
    final doc = await PDFDocument.fromURL(url,headers: requestHeaders);

    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2.0,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PatientList()));
          },
        ),
        title: Text('Report'),
      ),
      body: SafeArea(
          child: _loading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: _doc)),
    );
  }
}

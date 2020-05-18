import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:patient_care/models/patient.dart';
import 'dart:convert';

Future<List<Patient>> fetchCompletedPatient([String filter]) async {
  String url =
      'https://mcw-gspmc.tk/api/resource/Order?fields=["_read","patient_first_name","patient_last_name","name","status","report_date","report"]&filters=[["status", "=", "Reported"]]&order_by=_read%20asc&limit_page_length=999';

  if (filter != null) {
    url = url + "&filters=[$filter]";
  }
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Cookie': cookie
  };
  List<Patient> list;

  final response = await http.get(url, headers: requestHeaders);
  var data = json.decode(response.body)['data'] as List;
  list = data.map<Patient>((json) => Patient.fromJson(json)).toList();
  return list;
}

Future<List<Patient>> fetchPendingPatient([String filter]) async {
  String url =
      'https://mcw-gspmc.tk/api/resource/Order?fields=["_read","patient_first_name","patient_last_name","name","status"]&filters=[["status", "=", "In Progress"]]&order_by=_read%20asc&limit_page_length=999';

  if (filter != null) {
    url = url + "&filters=[$filter]";
  }
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Cookie': cookie
  };
  List<Patient> list;

  final response = await http.get(url, headers: requestHeaders);
  var data = json.decode(response.body)['data'] as List;
  list = data.map<Patient>((json) => Patient.fromJson(json)).toList();
  return list;
}

void markRead(patientid) async {
  String url = 'https://mcw-gspmc.tk/api/resource/Order/$patientid';
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': cookie
  };
  final Map<String, dynamic> data = {'_read': 1};
  await http.put(url, body: json.encode(data), headers: requestHeaders);
}

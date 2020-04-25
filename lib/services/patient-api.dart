import 'package:http/http.dart' as http;
import 'package:patient_care/models/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<List<Patient>> fetchPatient([String filter]) async {
  String url = 'https://mcw-gspmc.tk/api/resource/Order?fields=["_read","patient_first_name","patient_last_name","name","status","report_date","report"]&order_by=_read%20asc';
  
  if(filter != null){
    url = url + "&filters=[$filter]";
  }
  SharedPreferences pref = await SharedPreferences.getInstance();
  List<Patient> list;
 
  Map<String,String> requestHeaders = {
      //  'Content-Type': 'application/x-www-form-urlencoded',
       'Accept': 'application/json',
       'Cookie': pref.getString('cookie')
     };
  
  final response = await http.get(url,headers: requestHeaders); 
  // print(response.body);
  var data =json.decode(response.body)['data'] as List;
  list = data.map<Patient>((json) => Patient.fromJson(json)).toList();
  return list; 
}




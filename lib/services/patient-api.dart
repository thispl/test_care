import 'package:http/http.dart' as http;
import 'package:patient_care/models/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<List<Patient>> fetchPatient() async {
  String url = 'https://mcw.teamproit.com/api/resource/Patient?fields=["_seen","first_name","last_name","age","conditions"]';
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

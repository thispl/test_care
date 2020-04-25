import 'package:http/http.dart' as http;
import 'package:patient_care/models/license_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<List<LicenseInfo>> fetchLicenseInfo() async {
  String url = 'https://mcw-gspmc.tk/api/resource/License Information?fields=["title","description"]';
  SharedPreferences pref = await SharedPreferences.getInstance();
  List<LicenseInfo> list;
 
  Map<String,String> requestHeaders = {
      //  'Content-Type': 'application/x-www-form-urlencoded',
       'Accept': 'application/json',
       'Cookie': pref.getString('cookie')
     };
  
  final response = await http.get(url,headers: requestHeaders); 
  // print(response.body);
  var data =json.decode(response.body)['data'] as List;
  list = data.map<LicenseInfo>((json) => LicenseInfo.fromJson(json)).toList();
  return list; 
}

import 'package:http/http.dart' as http;
import 'package:patient_care/models/license_info.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'dart:convert';
import 'dart:core';

Future<List<LicenseInfo>> fetchLicenseInfo() async {
  String url =
      'https://www.mcw-gspmc.tk/api/resource/License Information?fields=["title","description"]';
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Cookie': cookie
  };
  final response = await http.get(url, headers: requestHeaders);
  List<LicenseInfo> list = [];
  if (response.statusCode == 200) {
    var data = json.decode(response.body)['data'] as List;
    list = data.map<LicenseInfo>((json) => LicenseInfo.fromJson(json)).toList();
  }
  return list;
}

 Future<List> fetchTerms() async{
  List terms = [];
  String url =
      'https://www.mcw-gspmc.tk/api/resource/License Information/Terms Of Use';
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Cookie': cookie
  };
  final response = await http.get(url, headers: requestHeaders);
  var data = json.decode(response.body)['data'];
  terms.add(data['title']);
  terms.add(data['description']);
  return terms;
}

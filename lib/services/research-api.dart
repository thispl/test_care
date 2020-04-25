import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:patient_care/models/research.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<List<Research>> fetchResearch() async {
  String url = 'https://www.wrike.com/api/v4/folders/';
  var token = await getToken();
  if (token != null) {
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    var data = json.decode(response.body)['data'] as List;
    List<Research> list =
        data.map<Research>((json) => Research.fromJson(json)).toList();
    return list;
  } 
}

Future<String> getToken() async {
  String url = 'https://mcw-gspmc.tk/api/resource/Settings/Settings';

  SharedPreferences pref = await SharedPreferences.getInstance();
  Map<String, String> requestHeaders = {
    //  'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
    'Cookie': pref.getString('cookie')
  };
  final response = await http.get(url, headers: requestHeaders);
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body)['data'];
    return jsonData['wrike_token'];
  } else {
    return 'Error:' + response.statusCode.toString();
  }
}

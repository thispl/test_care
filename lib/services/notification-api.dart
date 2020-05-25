import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'dart:core';

deviceRegistration(token) async {
  bool _isNewToken = true;
  List data = [];
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  String userid = await pref.getString('user_id');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Cookie': cookie
  };
  String url =
      'https://www.mcw-gspmc.tk/api/resource/Notification Device ID?filters=[["user","=","$userid"]]&fields=["device_id"]';
  final response = await http.get(url, headers: requestHeaders);
  data = json.decode(response.body)['data'];
  if (data.isNotEmpty) {
    final deviceId = (data[0]['device_id']);
    if (token == deviceId) {
      _isNewToken = false;
    }
  }
  if (_isNewToken) {
    String url =
        'https://www.mcw-gspmc.tk/api/resource/Notification Device ID?data={"user":"$userid","device_id":"$token"}';
    final response = await http.post(url, headers: requestHeaders);
    print(response.body);
  }
}

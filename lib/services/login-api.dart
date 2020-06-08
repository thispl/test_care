import 'package:http/http.dart' as http;
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'dart:convert';
import 'dart:core';
import  'package:patient_care/utilities/constants.dart';

Future submitAgreement(password) async {
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  String userid = await pref.getString('user_id');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': cookie
  };

  String url = server + '/resource/System User/$userid';

  final Map<String, dynamic> data = {'agreed': 1};
  final response =
      await http.put(url, body: json.encode(data), headers: requestHeaders);
  return response.statusCode.toInt();
}

Future<bool> checkAgreed() async {
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  String userid = await pref.getString('user_id');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': cookie
  };
  print(cookie);
  String url = server + '/resource/System User/$userid';
  final response = await http.get(url, headers: requestHeaders);
  print(response.body);
  var data = json.decode(response.body)['data'];
  return data['agreed'] == 1 ? true : false;
}

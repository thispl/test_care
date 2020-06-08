import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:patient_care/models/research.dart';
import 'dart:convert';
import 'package:patient_care/utilities/constants.dart';

Future<List<Research>> fetchResearch([String filter]) async {
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  String userId = await pref.getString('user_id');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Cookie': cookie
  };

  String url =
      server + '/resource/Research Project?fields=["*"]';

  if (filter != null) {
    url = url + "&filters=[['user_id','=','$userId']]";
  }

  List<Research> list = [];

  final response = await http.get(url, headers: requestHeaders);
  if (response.statusCode == 200) {
    var data = json.decode(response.body)['data'] as List;
    list = data.map<Research>((json) => Research.fromJson(json)).toList();
  }
   return list;
  
}

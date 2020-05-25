import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FrappeService {
  Future<List<String>> getList(url) async {
    List list = [];
    try {
      String apiUrl = 'https://www.mcw-gspmc.tk' + url;
      EncryptedSharedPreferences pref = EncryptedSharedPreferences();
      String cookie = await pref.getString('cookie');
      Map<String, String> requestHeaders = {
        'Accept': 'application/json',
        'Cookie': cookie
      };
      final response = await http.get(apiUrl, headers: requestHeaders);
      return list = json.decode(response.body)['data'];
    } catch (e) {
      print(e);
    }
  }
}

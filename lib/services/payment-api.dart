import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:patient_care/models/knowledgebase/payment_info.dart';

Future<List<String>> fetchSquareInfo() async {
  String url = 'https://www.mcw-gspmc.tk/api/resource/Settings/Settings';
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Cookie': cookie
  };
  final response = await http.get(url, headers: requestHeaders);
  final data = json.decode(response.body)['data'];
  List<String> ids = [];
  ids.add(data['square_application_id']);
  ids.add(data['square_location_id']);
  return ids;
}

Future<double> fetchAmount() async {
  String url = 'https://www.mcw-gspmc.tk/api/resource/Payment Settings/Payment Settings';
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Cookie': cookie
  };
  final response = await http.get(url, headers: requestHeaders);
  final data = json.decode(response.body)['data'];
  return data['amount'];
}

Future<String> processPayment(String nonce,double amount,String userId,String locationId) async {
  String url = 'https://www.mcw-gspmc.tk/api/method/mcw.payment.create_payment?nonce=$nonce&amount=$amount&user_id=$userId&location_id=$locationId';
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Cookie': cookie
  };
  // final Map<String, dynamic> data = {'nonce': nonce,'amount':amount,'user_id':userId,'location_id':locationId};
  final response = await http.post(url, headers: requestHeaders);
  final code = json.decode(response.body);
  return code['message'];

}


Future<List<PaymentInfo>> fetchPayment() async {
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  String userid = await pref.getString('user_id');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Cookie': cookie
  };
  String url =
      'https://www.mcw-gspmc.tk/api/resource/Payment?fields=["name","amount_paid"]&filters=[["user","=","$userid"]]';
  final response = await http.get(url, headers: requestHeaders);
  List<PaymentInfo> list;
  if (response.statusCode == 200) {
    var data = json.decode(response.body)['data'] as List;
    list = data.map<PaymentInfo>((json) => PaymentInfo.fromJson(json)).toList();
  }
  return list;
}
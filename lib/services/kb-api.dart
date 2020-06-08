import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:patient_care/models/knowledgebase/article.dart';
import 'dart:convert';

import 'package:patient_care/models/knowledgebase/topic.dart';
import 'package:patient_care/utilities/constants.dart';

// class KBServices {
//   static String url = server + '/resource/Article?fields=["*"]';

//   static Future<List<Article>> fetchArticle() async {
//     try {
//       EncryptedSharedPreferences pref = EncryptedSharedPreferences();
//       String cookie = await pref.getString('cookie');
//       Map<String, String> requestHeaders = {
//         'Accept': 'application/json',
//         'Cookie': cookie
//       };

//       // if (filter != null) {
//       //   url = url + "&filters=[$filter]";
//       // }

//       final response = await http.get(url, headers: requestHeaders);

//       if (response.statusCode == 200) {
//         List<Article> list = parseArticles(response.body);
//         return list;
//       } else {
//         throw Exception("Error" + response.statusCode.toString());
//       }
//     } catch (e) {
//       throw Exception("Error" + e.toString());
//     }
//   }

//   static List<Article> parseArticles(String responseBody) {
//     final parsed = json.decode(responseBody)['data'] as List;
//     return parsed.map<Article>((json) => Article.fromJson(json)).toList();
//   }
// }

Future<List<Article>> fetchArticle(String filter) async {
  try {
    String url =
        server + '/resource/Article?fields=["article_name","topic","description","video","video_url"]';
    EncryptedSharedPreferences pref = EncryptedSharedPreferences();
    String cookie = await pref.getString('cookie');
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Cookie': cookie
    };

    if (filter != null) {
      url = url + '&filters=[["topic","=","$filter"]]';
    }
    List<Article> list = [];
    final response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      list = parseArticles(response.body);
    } else {
      throw Exception("Error" + response.statusCode.toString());
    }
    return list;
  } 
  catch (e) {
    print(e);
    // throw Exception("Error" + e.toString());
  }
}

List<Article> parseArticles(String responseBody) {
  final parsed = json.decode(responseBody)['data'] as List;
  return parsed.map<Article>((json) => Article.fromJson(json)).toList();
}

Future<List<Topic>> fetchTopics([String filter]) async {
  String url = server + '/resource/Topic?fields=["is_premium","topic","image"]&limit_page_length=999';
  print(url);

  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Cookie': cookie
  };
  List<Topic> list = [];

  final response = await http.get(url, headers: requestHeaders);
  var data = json.decode(response.body)['data'] as List;
  list = data.map<Topic>((json) => Topic.fromJson(json)).toList();
  return list;
}

Future<bool> checkPremiumUser() async {
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  
  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': cookie
  };
String userid = await pref.getString('user_id');
  String url = server + '/resource/System User/$userid';
  final response = await http.get(url, headers: requestHeaders);
  var data = json.decode(response.body)['data'];
  return data['ispremium'] == 1 ? true : false;
}

void markPremiumUser() async {
  EncryptedSharedPreferences pref = EncryptedSharedPreferences();
  String cookie = await pref.getString('cookie');
  String userid = await pref.getString('user_id');
  String url = server + '/resource/System User/$userid';

  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': cookie
  };
  final Map<String, dynamic> data = {'ispremium': 1};
  await http.put(url, body: json.encode(data), headers: requestHeaders);
}




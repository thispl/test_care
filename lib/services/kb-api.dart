import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:patient_care/models/knowledgebase/article.dart';
import 'dart:convert';

// class KBServices {
//   static String url = 'https://mcw-gspmc.tk/api/resource/Article?fields=["*"]';

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



  Future<List<Article>> fetchArticle() async {
    try {
      String url = 'https://mcw-gspmc.tk/api/resource/Article?fields=["*"]';
      EncryptedSharedPreferences pref = EncryptedSharedPreferences();
      String cookie = await pref.getString('cookie');
      Map<String, String> requestHeaders = {
        'Accept': 'application/json',
        'Cookie': cookie
      };

      // if (filter != null) {
      //   url = url + "&filters=[$filter]";
      // }
      
      final response = await http.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        List<Article> list = parseArticles(response.body);
        return list;
      } else {
        throw Exception("Error" + response.statusCode.toString());
      }
    } catch (e) {
      throw Exception("Error" + e.toString());
    }
  }

  List<Article> parseArticles(String responseBody) {
    final parsed = json.decode(responseBody)['data'] as List;
    return parsed.map<Article>((json) => Article.fromJson(json)).toList();
  }

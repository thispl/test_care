import 'package:http/http.dart' as http;
import 'package:patient_care/models/knowledgebase/article.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class KBServices{
  static const String url = 'https://mcw.teamproit.com/api/resource/Article?fields=["*"]';

static Future<List<Article>> fetchArticle() async {
  try
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String,String> requestHeaders = {
      //  'Content-Type': 'application/x-www-form-urlencoded',
       'Accept': 'application/json',
       'Cookie': pref.getString('cookie')
     };
  
    final response = await http.get(url,headers: requestHeaders); 

    if(response.statusCode == 200){
      List<Article> list = parseArticles(response.body);
      return list;
    }
    else{
      throw Exception("Error"+response.statusCode.toString());
    }
  
  }
  catch(e){
    throw Exception("Error"+e.toString());
  }
  
}

static List<Article> parseArticles(String responseBody){
  final parsed = json.decode(responseBody)['data'] as List;
  return parsed.map<Article>((json) => Article.fromJson(json)).toList();
}


}


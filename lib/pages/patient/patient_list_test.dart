import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:patient_care/models/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _pairList = <Patient>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _itemFetcher = _ItemFetcher();

  bool _isLoading = true;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _loadMore();
  }

  void _loadMore() {
    _isLoading = true;
    _itemFetcher.fetchPatient().then((List<Patient> fetchedList) {
      print(fetchedList);
      if (fetchedList.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _pairList.addAll(fetchedList);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        // Need to display a loading tile if more items are coming
        itemCount: _hasMore ? _pairList.length + 1 : _pairList.length,
        itemBuilder: (BuildContext context, int index) {
          // Uncomment the following line to see in real time how ListView.builder works
          // print('ListView.builder is building index $index');
          if (index >= _pairList.length) {
            if (!_isLoading) {
              _loadMore();
            }
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 24,
                width: 24,
              ),
            );
          }
          return ListTile(
            leading: Text(index.toString(), style: _biggerFont),
            title: Text(_pairList[index].firstName, style: _biggerFont),
          );
        },
      ),
    );
  }
}

class _ItemFetcher {
  final _count = 38;
  final _itemsPerPage = 20;
  int _currentPage = 0;

  // This async function simulates fetching results from Internet, etc.
  // Future<List<WordPair>> fetch() async {
  //   final list = <WordPair>[];
  //   final n = min(_itemsPerPage, _count - _currentPage * _itemsPerPage);
  //   // Uncomment the following line to see in real time now items are loaded lazily.
  //   // print('Now on page $_currentPage');
  //   await Future.delayed(Duration(seconds: 1), () {
  //     for (int i = 0; i < n; i++) {
  //       list.add(WordPair.random());
  //     }
  //   });
  //   _currentPage++;
  //   return list;
  // }

  Future<List<Patient>> fetchPatient([String filter]) async {
    final list = <Patient>[];

    final n = min(_itemsPerPage, _count - _currentPage * _itemsPerPage);
    String url =
        'https://mcw-gspmc.tk/api/resource/Order?fields=["_read","patient_first_name","patient_last_name","name","status","report_date","report"]&order_by=_read%20asc';

    if (filter != null) {
      url = url + "&filters=[$filter]";
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<Patient> datalist;

    Map<String, String> requestHeaders = {
      //  'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Cookie': pref.getString('cookie')
    };

    final response = await http.get(url, headers: requestHeaders);
    // print(response.body);
    var data = json.decode(response.body)['data'] as List;
    // datalist = data.map<Patient>((json) => Patient.fromJson(json)).toList();
    for (int i = 0; i < n; i++) {
      datalist = data.map<Patient>((json) => Patient.fromJson(json)).toList();
    }
    _currentPage++;
    return datalist;
  }
}

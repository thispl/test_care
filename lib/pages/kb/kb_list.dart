import 'package:flutter/material.dart';
import 'package:patient_care/models/knowledgebase/article.dart';
import 'package:patient_care/services/kb-api.dart';
import 'package:patient_care/pages/kb/kb_detail.dart';

import 'kb_topics.dart';

class KBList extends StatefulWidget {
  @override
  _KBListState createState() => _KBListState();
}

class _KBListState extends State<KBList> {
  List<Article> articles = List();
  List<Article> filteredArticles = List();
  bool error = false;
  @override
  void initState() {
    super.initState();
    fetchArticle().then((articlesFromServer) {
      setState(() {
        articles = articlesFromServer;
        filteredArticles = articles;
      });
    }).catchError((e) {
      setState(() {
        error = true;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 2.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => KBTopics()));
              },
            ),
            backgroundColor: Colors.teal,
            title: Text('Topic Info',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0)),
            actions: <Widget>[
              // action button
            ]),
        body: SafeArea(
          child: error
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: 'Enter Article Name or Topic',
                      ),
                      onChanged: (string) {
                        setState(() {
                          filteredArticles = articles
                              .where((a) =>
                                  a.articleName
                                      .toLowerCase()
                                      .contains(string.toLowerCase()) ||
                                  a.topic
                                      .toLowerCase()
                                      .contains(string.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                    // Expanded(
                    //   child: Center(child: CircularProgressIndicator()),
                    // ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: filteredArticles.length,
                          padding: const EdgeInsets.all(2.0),
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(
                                  filteredArticles[index].articleName,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  filteredArticles[index].topic,
                                  style: TextStyle(
                                      // fontSize: 18.0,
                                      color: Colors.teal[400],
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () => _onTapItem(
                                    context, filteredArticles[index]),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
        )
        // child: FutureBuilder(
        //     future: fetchArticle,
        //     builder: (context, snapshot) {
        //       return snapshot.data != null
        //           ? listViewWidget(snapshot.data)
        //           : Center(child: CircularProgressIndicator());
        //     }),

        );
  }
}

void _onTapItem(BuildContext context, Article article) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => KBDetail(article: article)));
}

Widget _showLoading(error) {
  return Center(child: CircularProgressIndicator());
}

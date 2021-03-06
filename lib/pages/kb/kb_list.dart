import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:patient_care/models/knowledgebase/article.dart';
import 'package:patient_care/models/knowledgebase/topic.dart';
import 'package:patient_care/services/kb-api.dart';
import 'package:patient_care/pages/kb/kb_detail.dart';
import 'kb_topics.dart';

class KBList extends StatefulWidget {

  final String topic;
  KBList({Key key, @required this.topic}) : super(key: key);

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
    fetchArticle(widget.topic).then((articlesFromServer) {
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
              ? ListSkeleton(
                  style: SkeletonStyle(
                    theme: SkeletonTheme.Light,
                    isShowAvatar: false,
                    barCount: 3,
                    colors: [
                      Colors.teal.shade100,
                      Colors.teal.shade300,
                      Colors.teal.shade500,
                    ],
                    isAnimation: true,
                  ),
                )
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
  return ListSkeleton(
    style: SkeletonStyle(
      theme: SkeletonTheme.Light,
      isShowAvatar: false,
      barCount: 3,
      colors: [
        Colors.teal.shade100,
        Colors.teal.shade300,
        Colors.teal.shade500,
      ],
      isAnimation: true,
    ),
  );
}

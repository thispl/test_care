import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:patient_care/models/knowledgebase/article.dart';
import 'package:patient_care/pages/modules_menu.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:video_player/video_player.dart';

import 'kb_list.dart';

class KBDetail extends StatefulWidget {
  final Article article;
  KBDetail({Key key, @required this.article}) : super(key: key);

  @override
  _KBDetailState createState() => _KBDetailState();
}

class _KBDetailState extends State<KBDetail> {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  bool _hasVideo = false;

  @override
  void initState() {
    super.initState();
    String videoUrl;
    // Create an store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    if (widget.article.video != null) {
      videoUrl = 'https://www.mcw-gspmc.tk' + widget.article.video;
    }
    String url = videoUrl ?? widget.article.videoLink ?? null;
    if (url != null) {
      _hasVideo = true;
      _controller = VideoPlayerController.network(url);

      _chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (_hasVideo) {
                _chewieController.dispose();
                _controller.pause();
              }
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => KBList(topic: widget.article.topic,)));
            },
          ),
          title: Text(widget.article.articleName,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0)),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ModulesMenu()));
              },
            ),
          ]),
      body: Stack(
        children: <Widget>[
          Container(
              height: 200.0,
              child: _hasVideo
                  ? Chewie(
                      controller: _chewieController,
                    )
                  : Center(child: Text('No Video Available'))),
          _buildRemark(context, this.widget.article),
        ],
      ),
    );
  }
}

Container _buildRemark(context, article) {
  return Container(
    margin: EdgeInsets.only(top: 200.0),
    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
    child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        color: Colors.teal.shade50,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(article.topic),
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {},
                    )
                  ],
                ),
                Text(
                  article.articleName.toString(),
                  style: Theme.of(context).textTheme.headline,
                ),
                Divider(),
                SizedBox(
                  height: 10.0,
                ),
                // Text(
                Html(
                  data: article.description ?? '',
                ),
                //   textAlign: TextAlign.justify,
                // )
              ],
            ),
          ]),
        )),
  );
}

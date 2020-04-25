import 'package:flutter/material.dart';
import 'package:patient_care/models/knowledgebase/article.dart';
import 'package:patient_care/pages/modules_menu.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:video_player/video_player.dart';

import 'kb_list.dart';

class KBDetail extends StatefulWidget {
  // static final String path = "lib/src/pages/profile/profile2.dart";
  final Article article;
  KBDetail({Key key, @required this.article}) : super(key: key);

  @override
  _KBDetailState createState() => _KBDetailState();
}

class _KBDetailState extends State<KBDetail> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    // Create an store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => KBList()));
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
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization, use
                  // the data it provides to limit the aspect ratio of the VideoPlayer.
                  return 
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    // Use the VideoPlayer widget to display the video.
                    child: VideoPlayer(_controller),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            // decoration: BoxDecoration(
            //   ),
            // ),
          ),
          _buildRemark(context, this.widget.article),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
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

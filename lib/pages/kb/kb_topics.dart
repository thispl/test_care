import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:patient_care/models/knowledgebase/topic.dart';
import 'package:patient_care/pages/kb/kb_list.dart';
import 'package:patient_care/pages/modules_menu.dart';
import 'package:patient_care/pages/payments/payment.dart';
import 'package:patient_care/services/kb-api.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shimmer/shimmer.dart';

class KBTopics extends StatelessWidget {
  KBTopics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            // elevation: 2.0,
            backgroundColor: Colors.teal,
            leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ModulesMenu()));
              },
            ),
            title: Text('Knowledge Base',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0)),
            actions: <Widget>[
              // action button
            ]),
        body: SafeArea(
          child: buildTopic(),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Payments()));
          },
          child: Container(
            height: 140.0,
            decoration: ShapeDecoration(
                shape: PolygonBorder(
                    sides: 8,
                    borderRadius: 5.0,
                    rotate: 22.5,
                    border: BorderSide(color: Colors.grey.shade700, width: 2))),
            child: ClipPolygon(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Container(
                        color: Colors.grey,
                        child: Center(
                          child: Icon(
                            LineAwesomeIcons.cc_paypal,
                            size: 60,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  Expanded(
                    // alignment: Alignment.bottomCenter,
                    flex: 3,
                    child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text('Premium',
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        )),
                  ),
                ],
              ),
              boxShadows: [
                PolygonBoxShadow(color: Colors.black, elevation: 5.0),
              ],
              sides: 8,
              rotate: 22.5,
              borderRadius: 5.0,
            ),
          ),
        )
        // FloatingActionButton(
        //     onPressed: () => Navigator.of(context).push(MaterialPageRoute(
        //         builder: (BuildContext context) => Payments()))),
        );
  }

  Container buildTopic() {
    return Container(
      child: FutureBuilder(
          future: fetchTopics(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              if (snapshot.hasError) {
                Alert(
                        context: context,
                        title: "Connection Failed",
                        desc: snapshot.data)
                    .show();
              }
              List<Topic> topic = snapshot.data;
              return topic.length <= 0
                  ? Container(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.announcement),
                          Text('No Data Found'),
                        ],
                      )),
                    )
                  : Container(
                      child: GridView.count(
                          crossAxisCount: 2,
                          children: List.generate(topic.length, (position) {
                            return _buildList(topic, position, context);
                          })));
            } else {
              return CardListSkeleton(
                style: SkeletonStyle(
                  theme: SkeletonTheme.Light,
                  isShowAvatar: true,
                  isCircleAvatar: true,
                  barCount: 2,
                ),
              );
            }
          }),
    );
  }

  Container _buildList(List<Topic> topic, int position, BuildContext context) {
    return Container(
      child: CupertinoButton(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: topic[position].image != ""
                  ? NetworkImage(
                      'https://www.mcw-gspmc.tk' + topic[position].image)
                  : AssetImage("assets/image_not_found.png"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Text(
                    '${topic[position].topic}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                topic[position].isPremium
                    ? Container(
                        alignment: Alignment.bottomRight,
                        child: Badge(
                          badgeColor: Colors.black,
                          shape: BadgeShape.square,
                          borderRadius: 5,
                          toAnimate: false,
                          badgeContent: Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.yellow,
                            child: Text(
                              'Premium',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        onPressed: () {
          topic[position].isPremium
              ? isPremiumUser(context, topic[position].topic)
              : Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => KBList(
                        topic: topic[position].topic,
                      )));
        },
      ),
    );
  }
}

isPremiumUser(context, topic) {
  checkPremiumUser().then((value) {
    if (value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => KBList(
                topic: topic,
              )));
    } else {
      Alert(
          context: context,
          type: AlertType.info,
          title: "Premium Content",
          desc: "Content is only Available for Premium Members",
          buttons: [
            DialogButton(
              child: Text(
                "Interested?",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Payments(),
                  ),
                  (Route<dynamic> route) => false);
              },
              width: 120,
            )
          ],
          closeFunction: () =>
              Navigator.of(context, rootNavigator: true).pop()
              ).show();
    }
  });
}

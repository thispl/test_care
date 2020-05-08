import 'package:flutter/material.dart';
import 'package:patient_care/pages/modules_menu.dart';
import 'package:patient_care/pages/patient/patient_list.dart';
import 'package:patient_care/pages/research/research_list.dart';
import 'package:patient_care/pages/kb/kb_topics.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:patient_care/pages/settings.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class GridMenu extends StatelessWidget {
  Items item1 = new Items(
    title: "Patients",
  );

  Items item2 = new Items(
    title: "Research",
  );
  Items item3 = new Items(
    title: "Knowledge \n Base",
  );
  Items item4 = new Items(
    title: "Payment",
  );
  Items item5 = new Items(
    title: "Settings",
  );

  @override
  Widget build(BuildContext context) {
    final List _children = [
      ModulesMenu(),
      PatientList(),
      // ListScreen(),
      ResearchList(),
      KBTopics(),
      Settings()
    ];
    final List _icons = [
      Icon(
        LineAwesomeIcons.home,
        size: 60.0,
        color: Colors.white,
      ),
      Icon(
        LineAwesomeIcons.stethoscope,
        size: 60.0,
        color: Colors.white,
      ),
      Icon(
        LineAwesomeIcons.flask,
        size: 60.0,
        color: Colors.white,
      ),
      Icon(
        LineAwesomeIcons.book,
        size: 60.0,
        color: Colors.white,
      ),
      Icon(
        LineAwesomeIcons.cc_paypal,
        size: 60.0,
        color: Colors.white,
      ),
    ];
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                ),
                buildMenu(context, _children[1], _icons[1], item1.title),
                buildMenu(context, _children[2], _icons[2], item2.title),
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 80.0,
                ),
                buildMenu(context, _children[3], _icons[3], item3.title),
                buildMenu(context, _children[4], _icons[4], item4.title),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildMenu(BuildContext context, _children, _icons, title) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => _children));
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
                      child: _icons,
                    )),
              ),
              Expanded(
                // alignment: Alignment.bottomCenter,
                flex: 3,
                child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)
                      ),
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
    );
  }
}

// _handleTap(context, index) {
//   Navigator.of(context)
//       .push(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
// }

class Items {
  final String title;
  final String img;
  final int index;
  Items({this.title, this.img, this.index});
}

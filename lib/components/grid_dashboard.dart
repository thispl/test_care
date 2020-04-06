import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient_care/pages/modules_menu.dart';
import 'package:patient_care/pages/patient/patient_list.dart';
import 'package:patient_care/pages/research/research_list.dart';
import 'package:patient_care/pages/kb/kb_topics.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:patient_care/pages/settings.dart';
import 'package:polygon_clipper/polygon_border.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
    title: "Patients",
    index: 1,
    img: "assets/menu_icons/research.png",
  );

  Items item2 = new Items(
    title: "Research",
    index: 2,
    img: "assets/menu_icons/research.png",
  );
  Items item3 = new Items(
    title: "Knowledge\nbase",
    index: 3,
    img: "assets/menu_icons/kb.png",
  );
  Items item4 = new Items(
    title: "Settings",
    index: 4,
    img: "assets/menu_icons/settings.png",
  );
  Items item5 = new Items(
    title: "Settings",
    index: 4,
    img: "assets/menu_icons/settings.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> list1 = [item1, item2];
    List<Items> list2 = [item3, item4];
    final List<Widget> _children = [
      ModulesMenu(),
      PatientList(),
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
        LineAwesomeIcons.gear,
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
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: GridView.count(
                childAspectRatio: 1.0,
                padding: EdgeInsets.only(left: 16, right: 16),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: list1.map((data) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              _children[data.index]));
                    },
                    child: Container(
                      decoration: ShapeDecoration(
                          shape: PolygonBorder(
                              sides: 8,
                              borderRadius: 5.0,
                              rotate: 25.0,
                              border: BorderSide(
                                  color: Colors.grey.shade700, width: 2))),
                      child: ClipPolygon(
                        child: Column(
                          children: <Widget>[
                            Flexible(
                              flex: 2,
                              child: Container(
                                  color: Colors.grey,
                                  child: Center(
                                    child: _icons[data.index],
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      data.title,
                                      softWrap: true,
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        boxShadows: [
                          PolygonBoxShadow(color: Colors.black, elevation: 5.0),
                        ],
                        sides: 8,
                        rotate: 25.0,
                        borderRadius: 5.0,
                      ),
                    ),
                  );
                }).toList()),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: GridView.count(
                childAspectRatio: 1.0,
                padding: EdgeInsets.only(left: 16, right: 16),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: list2.map((data) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              _children[data.index]));
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10,),
                        Container(
                          decoration: ShapeDecoration(
                              shape: PolygonBorder(
                                  sides: 8,
                                  borderRadius: 5.0,
                                  rotate: 25.0,
                                  border: BorderSide(
                                      color: Colors.grey.shade700, width: 2))),
                          child: ClipPolygon(
                            child: Column(
                              children: <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                      color: Colors.grey,
                                      child: Center(
                                        child: _icons[data.index],
                                      )),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      data.title,
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            boxShadows: [
                              PolygonBoxShadow(color: Colors.black, elevation: 5.0),
                            ],
                            sides: 8,
                            rotate: 25.0,
                            borderRadius: 5.0,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()),
          ),
        ],
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

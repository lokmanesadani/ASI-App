import 'package:asi_app/pages/home/students_list.dart';
import 'package:asi_app/pages/students/student_list_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable

// ignore: must_be_immutable
class DrawerItem extends StatefulWidget {
  String title;
  String promo;
  String groupe;
  final Map<dynamic, dynamic> promos;
  int index;
  DrawerItem({this.title, this.promos, this.index, this.groupe, this.promo});
  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20),
          child: ListTile(
            title: Text(
              'Groupe 1',
              style: TextStyle(fontSize: 14),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StudentPage(
                  groupe: '1',
                  promo: widget.promos.keys.elementAt(widget.index),
                ),
              ));
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: ListTile(
            title: Text(
              'Groupe 2',
              style: TextStyle(fontSize: 14),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StudentPage(
                  groupe: '2',
                  promo: widget.promos.keys.elementAt(widget.index),
                ),
              ));
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: ListTile(
            title: Text(
              'Groupe 3',
              style: TextStyle(fontSize: 14),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StudentPage(
                  groupe: '3',
                  promo: widget.promos.keys.elementAt(widget.index),
                ),
              ));
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          child: ListTile(
            title: Text(
              'Groupe 4',
              style: TextStyle(fontSize: 14),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StudentPage(
                  groupe: '4',
                  promo: widget.promos.keys.elementAt(widget.index),
                ),
              ));
            },
          ),
        ),
      ],
      title: Container(
        width: double.infinity,
        child: Text(
          widget.title,
          style: TextStyle(fontSize: 18),
        ),
      ),
      initiallyExpanded: false,
      onExpansionChanged: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      trailing: Icon(
        isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
        size: 32,
        color: isExpanded ? Colors.blue : Colors.black,
      ),
    );
  }
}

// ignore: must_be_immutable
class DrawerExpandedItem extends StatelessWidget {
  String title;
  String supertitle;
  DrawerExpandedItem({this.supertitle, this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}

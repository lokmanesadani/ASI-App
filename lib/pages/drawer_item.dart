import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DrawerItem extends StatefulWidget {
  String title;
  DrawerItem({this.title});
  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      children: [
        DrawerExpandedItem(supertitle: widget.title, title: 'title1'),
        DrawerExpandedItem(supertitle: widget.title, title: 'title2'),
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

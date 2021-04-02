import 'package:asi_app/models/Student.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StudentTile extends StatefulWidget {
  final Student student;
  bool checked;

  StudentTile({this.student, this.checked});
  @override
  _StudentTileState createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(6, 3, 6, 0),
        child: CheckboxListTile(
          title: Text(
            '${widget.student.name} ${widget.student.surname}',
          ),
          subtitle: Text(
            widget.student.email,
          ),
          onChanged: (bool value) {
            setState(() {
              widget.checked = !widget.checked;
            });
          },
          value: widget.checked,
          secondary: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            radius: 30,
          ),
          activeColor: Colors.red,
        ),
      ),
    );
  }
}

import 'package:asi_app/models/Student.dart';
import 'package:asi_app/pages/home/student_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class StudentsList extends StatefulWidget {
  String promo;
  String groupe;
  StudentsList({this.groupe, this.promo});
  @override
  _StudentsListState createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  Widget build(BuildContext context) {
    final allstudents = Provider.of<List<Student>>(context);
    final students = List<Student>();
    allstudents.forEach((student) {
      if ((student.groupe == widget.groupe) &&
          (student.promo == widget.promo)) {
        students.add(student);
      }
    });

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        return StudentTile(
          student: students[index],
          checked: false,
        );
      },
    );
  }
}

import 'package:asi_app/models/Student.dart';
import 'package:asi_app/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String uid;
  DatabaseService({this.uid});
  final CollectionReference teacher = Firestore.instance.collection('Teachers');
  final CollectionReference student = Firestore.instance.collection('Students');

  List<Student> _getStudents(QuerySnapshot snap) {
    return snap.documents.map((e) {
      return Student(
        name: e.data['name'] ?? '',
        surname: e.data['surname'] ?? '',
        email: e.data['email'] ?? '',
        promo: e.data['promo'] ?? '',
        groupe: e.data['groupe'] ?? '',
        absences: e.data['absences'],
      );
    }).toList();
  }

  UserData _userdatafromsnap(DocumentSnapshot snap) {
    return UserData(
        uid: uid,
        name: snap.data['name'],
        surname: snap.data['surname'],
        email: snap.data['Email'],
        promos: snap.data['promos']);
  }

  Stream<List<Student>> get students {
    return student.snapshots().map(_getStudents);
  }

  Stream<UserData> get userdata {
    return teacher.document(uid).snapshots().map(_userdatafromsnap);
  }
}

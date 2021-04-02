import 'package:asi_app/models/Student.dart';
import 'package:asi_app/models/User.dart';
import 'package:asi_app/pages/home/drawer.dart';
import 'package:asi_app/pages/home/students_list.dart';
import 'package:asi_app/pages/profile.dart';
import 'package:asi_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:asi_app/services/database.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class StudentPage extends StatefulWidget {
  String groupe;
  String promo;
  StudentPage({this.groupe, this.promo});
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<User>(this.context);

    return StreamProvider<List<Student>>.value(
      value: DatabaseService().students,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.promo} - ${widget.groupe} ',
          ),
        ),
        drawer: Drawer(
          child: StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid).userdata,
            builder: (context, snapshot) {
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 6,
                          right: 6,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 15,
                          child: Text(
                            '${snapshot.data.name} ${snapshot.data.surname}',
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 15,
                          child: Text(
                            '${snapshot.data.email}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 0),
                    height: 500,
                    child: ListView.builder(
                      itemCount: snapshot.data.promos.keys.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DrawerItem(
                          promos: snapshot.data.promos,
                          title: snapshot.data.promos.keys.elementAt(index),
                          index: index,
                        );
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                    ),
                    title: Text('Profile'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    tileColor: Colors.blueGrey,
                    title: Text('Sign out'),
                    onTap: () async {
                      await _auth.signOut();
                    },
                  ),
                ],
              );
            },
          ),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              StudentsList(groupe: widget.groupe, promo: widget.promo),
              Positioned(
                right: 15,
                bottom: 20,
                child: FloatingActionButton(
                  child: Icon(
                    Icons.check,
                    size: 30,
                  ),
                  onPressed: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

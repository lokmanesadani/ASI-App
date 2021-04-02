import 'package:asi_app/models/Student.dart';
import 'package:asi_app/models/User.dart';
import 'package:asi_app/pages/home/drawer.dart';
import 'package:asi_app/pages/home/students_list.dart';
import 'package:asi_app/pages/profile.dart';
import 'package:asi_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:asi_app/services/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirme liste'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('This is a confirmation message.'),
                Text('Would you like to confirm absences list?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                print('Confirmed');
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<User>(this.context);
    String groupe = '4';
    String promo = "2 CSSIT";
    return StreamProvider<List<Student>>.value(
      value: DatabaseService().students,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${promo} - ${groupe} ',
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
                          groupe: groupe,
                          promo: promo,
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
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    tileColor: Colors.blueGrey,
                    title: Text(
                      'Sign out',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
              StudentsList(groupe: groupe, promo: promo),
              Positioned(
                right: 15,
                bottom: 20,
                child: FloatingActionButton(
                  child: Icon(
                    Icons.check,
                    size: 30,
                  ),
                  onPressed: () {
                    _showMyDialog();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

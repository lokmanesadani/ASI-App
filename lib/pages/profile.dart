import 'package:asi_app/models/User.dart';
import 'package:asi_app/pages/home/drawer.dart';
import 'package:asi_app/services/auth.dart';
import 'package:asi_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userdata,
      builder: (context, snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
              ),
            ),
            drawer: Drawer(
              child: ListView(
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
                      await _auth.signOut();
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
              ),
            ),
            body: Card(
              margin: EdgeInsets.fromLTRB(20, 80, 20, 160),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 60,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data.name,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  snapshot.data.surname,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: Text(
                          'E-mail :      ${snapshot.data.email}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: Text(
                          'Promos :',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        height: 300,
                        width: 300,
                        child: ListView.builder(
                            itemCount:
                                snapshot.data.promos.keys.toList().length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(50, 30, 0, 0),
                                child: Text(
                                  ' ${snapshot.data.promos.keys.elementAt(index)}  - Module : ${snapshot.data.promos.values.elementAt(index).values.first}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}

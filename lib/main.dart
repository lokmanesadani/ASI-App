import 'package:asi_app/pages/wrapper.dart';
import 'package:asi_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/User.dart';

String password;
String username;

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          title: 'ASI App',
          theme: new ThemeData(
            fontFamily: 'MontserratBold',
            primarySwatch: Colors.blueGrey,
          ),
          home: Wrapper()),
    );
  }
}

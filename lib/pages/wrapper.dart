import 'package:asi_app/models/User.dart';
import 'package:asi_app/pages/home/home.dart';
import 'package:asi_app/pages/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // return home or login
    if (user == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }
}

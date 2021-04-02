import 'package:asi_app/services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  String username = '';
  String password = '';
  String usernameError = '';
  String passwordError = '';
  String error = '';
  // ignore: non_constant_identifier_names
  PageController log_sign = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    print("building login page");
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: Colors.blueGrey,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.72,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 70, bottom: 20),
                      padding: EdgeInsets.only(left: 100),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 25,
                          fontFamily: 'MontserratBold',
                        ),
                      ),
                    ),
                    Form(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.only(
                                left: 18,
                                top: 5,
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1,
                              ),
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() => username = val);
                                },
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'MontserratBold',
                                ),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.grey.shade600,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'E-mail',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 5, left: 25),
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              usernameError,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Container(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.only(
                                left: 18,
                                top: 5,
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1,
                              ),
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'MontserratBold',
                                ),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.grey.shade600,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 5, left: 25),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              passwordError,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 60,
                            margin: EdgeInsets.only(
                              top: 50,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.shade400,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                if (username.isEmpty && password.length < 8) {
                                  setState(() {
                                    usernameError = 'Enter username please';
                                    passwordError =
                                        'Password length is less than 8 chars';
                                  });
                                } else if (username.isEmpty) {
                                  setState(() {
                                    passwordError = '';
                                    usernameError = 'Enter username please';
                                  });
                                } else if (password.length < 8) {
                                  setState(() {
                                    usernameError = '';
                                    passwordError =
                                        'Password length is less than 8 chars';
                                  });
                                } else {
                                  setState(() {
                                    passwordError = '';
                                    usernameError = '';
                                  });
                                  dynamic result = await _auth.signInEmail(
                                      username, password);

                                  print(result);
                                  if (result == null) {
                                    setState(() {
                                      error = 'please supply a valide email';
                                    });
                                  }
                                }
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'MontserratBold',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              error,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

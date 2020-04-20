import 'package:catalogged/screens/wrapper.dart';
import 'package:catalogged/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:catalogged/screens/signin.dart';
import 'package:catalogged/screens/registration.dart';
import 'package:catalogged/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:catalogged/models/user.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
        child: MaterialApp(
        title: 'CataLogged',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}

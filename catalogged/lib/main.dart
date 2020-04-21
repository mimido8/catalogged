import 'package:catalogged/screens/wrapper.dart';
import 'package:catalogged/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:catalogged/screens/signin.dart';
import 'package:catalogged/screens/registration.dart';
import 'package:catalogged/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:catalogged/models/user.dart';
import 'package:provider/provider.dart';
import 'package:catalogged/notifier/receipt_notifier.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ReceiptNotifier(),
        ),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'CataLogged',
        theme: ThemeData(
          primaryColor: Colors.blue[900],
//          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}

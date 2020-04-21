import 'package:catalogged/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:catalogged/screens/authentication/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:catalogged/models/user.dart'
    '';

//determining whether to load home to sign in
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // return either the Home or Authenticate widget
    //If user signed in, redirect to home. If not, redirect to sign in.
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}

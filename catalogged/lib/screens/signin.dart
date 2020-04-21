import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:catalogged/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  //creating auth instance
  final AuthService _auth = AuthService();

  static const routeName = '/signUp';
  String _email, _password;
  String error = '';
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _keyForm,
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/receipt-logo.png',
                    height: 50,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("CataLogged",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                textColor: Colors.black,
                onPressed: () async {
                  dynamic result = await _auth.googleSignIn();
                  //if result == null
                  if (result == null) {
                    setState(() => error = 'Problems signing in with Google');
                  }
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.white,
                        width: 3.0,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/google-logo.png',
                      height: 15,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  child: Center(
                child: Text(
                  "or",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              )),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please enter an email';
                    } else if (!EmailValidator.validate(input)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (input) => _email = input,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ))),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  validator: (input) {
                    if (input.length < 6) {
                      return 'Your password must have atleast 6 characters';
                    }
                    return null;
                  },
                  onSaved: (input) => _password = input,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: () async {
                  FormState keyState = _keyForm.currentState;
                  //saving values into variables
                  keyState.save();
                  if (keyState.validate()) {
                    dynamic result = await _auth.signInUser(_email, _password);
                    //if result == null
                    if (result == null) {
                      setState(() => error = 'Incorrect email/password combo');
                    }
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.white,
                      width: 5.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Not Registered?",
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  FlatButton(
                    child: Text("Sign Up",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.cyanAccent,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      widget.toggleView();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
    //throw UnimplementedError();
  }
}

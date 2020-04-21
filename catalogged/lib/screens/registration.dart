import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:catalogged/services/auth.dart';

class SignUp extends StatefulWidget{
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp>{
  static const routeName = '/signUp';
  //creating auth instance
  final AuthService _auth = AuthService();


  String _email, _password;
  String error = "";
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
                  Text("CataLogged", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white))
                ],
              ),
              Center(child: Text(error, style: TextStyle(color: Colors.red, fontSize: 15))),
              SizedBox(
                  child: Center(
                    child: Text("Sign up with us!", style: TextStyle(fontSize: 20, color: Colors.white70),),
                  )
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  validator: (input) {
                    if(input.isEmpty){
                      return 'Please enter an email';
                    }
                    else if(!EmailValidator.validate(input)){
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
                      )
                  )
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  validator: (input) {
                    if(input.length < 6){
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
                      )
                  )
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  validator: (input) {
                    if(input.isEmpty){
                      return 'Please confirm your password';
                    }
                    else if(input != _password){
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Confirm password',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      )
                  )
              ),
              Center(child: Text(error, style: TextStyle(color: Colors.red, fontSize: 15))),
              FlatButton(
                onPressed: () async{
                  FormState keyState = _keyForm.currentState;
                  //saving values into variables
                  keyState.save();
                  if(keyState.validate()){
                    dynamic result = await _auth.signUpUser(_email, _password);
                    //if result == null
                    if(result==null){
                      setState(() => error = 'Invalid credentials');
                    }
                  }
                },
                child: Text("Sign up",
                  style: TextStyle(fontSize: 15,
                      color: Colors.white),
                ),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 5.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already Registered?", style: TextStyle(fontSize: 15, color: Colors.white)),
                  FlatButton(
                    child: Text("Sign In", style: TextStyle(fontSize: 18, color: Colors.cyanAccent, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                    onPressed: (){
                      widget.toggleView();},
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget{
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp>{
  String _email, _password, _password2, _firstName, _lastName, _phoneNumber;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){},
        ),
        title: Text('Sign Up'),
      ),
      body: Form(
        key: _keyForm,
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/receipt-logo.png',
                height: 80,
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                textColor: Colors.black,
                onPressed: () {
                  /*...*/
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 3.0, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/google-logo.png', height: 15,),
                    SizedBox(width: 10,),
                    Text('Sign in with Google', style: TextStyle(fontSize: 15),)
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  child: Center(
                    child: Text("or Sign up with us!", style: TextStyle(fontSize: 15, color: Colors.white),),
                  )
              ),
              SizedBox(
                height: 20,
              ),
              /*TextFormField(
                  validator: (input) {
                    if(input.isEmpty){
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onSaved: (input) => _firstName = input,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'First name',
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
                    if(input.isEmpty){
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onSaved: (input) => _lastName = input,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Last name',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      )
                  )
              ),
              SizedBox(
                height: 20,
              ), */
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
                    if(input.isEmpty){
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (input) => _phoneNumber = input,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Phone number',
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
                  onSaved: (input) => _password2 = input,
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
              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: (){
                  FormState keyState = _keyForm.currentState;
                  //saving values into variables
                  keyState.save();
                  keyState.validate();
                },
                child: Text("Login",
                  style: TextStyle(fontSize: 15,
                      color: Colors.white),
                ),
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 3.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //throw UnimplementedError();
  }
}
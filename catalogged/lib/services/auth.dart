import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalogged/models/user.dart';

class AuthService{
  //creating a firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creating user object based on Firebase User
  User _userFromFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid, email: user.email, phoneNum: user.phoneNumber) : null;
  }

  //TODO Sign in with email

  //TODO Register with email and password
}
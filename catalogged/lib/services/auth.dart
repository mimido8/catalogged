import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalogged/models/user.dart';

class AuthService{
  //creating a firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creating user object based on Firebase User
  User _userFromFirebase(FirebaseUser user){
    //If user is not null, created user object. Otherwise, user set to null
    return user != null ? User(uid: user.uid, email: user.email, phoneNum: user.phoneNumber) : null;
  }

  //Authenticating  user stream, will return null if user signs out.
  Stream <User> get user {
    //return firebase user if change in stream and map to our user model
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  //Sign out function
  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //TODO Sign in with email
  Future signInUser(String email, String password) async {
    try{
      //returning our user object based off user from firebase
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }
    //if can't register, return null
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //TODO Register with email and password
  Future signUpUser(String email, String password) async {
    try{
      //returning our user object based off user from firebase
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }
    //if can't register, return null
    catch(e){
      print(e.toString());
      return null;
    }
  }
}
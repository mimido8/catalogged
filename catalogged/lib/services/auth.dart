import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalogged/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  //creating a firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //creating google Signin Instance
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  //creating user object based on Firebase User
  User _userFromFirebase(FirebaseUser user){
    //If user is not null, created user object. Otherwise, user set to null
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  //Authenticating  user stream, will return null if user signs out.
  Stream <User> get user {
    //return firebase user if change in stream and map to our user model
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  //Google sign in
  Future googleSignIn() async {
    try{
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);
      return _userFromFirebase(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
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

  //Sign in with email
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

  //Register with email and password
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
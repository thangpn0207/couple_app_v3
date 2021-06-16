import 'package:couple_app_v3/locator.dart';
import 'package:couple_app_v3/model/user_model.dart';
import 'package:couple_app_v3/services/repository_service.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';
// ignore: import_of_legacy_library_into_null_safe

class Authentication {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final Repository _repository = locator<Repository>();

  Authentication({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ??
            GoogleSignIn(scopes: <String>[
              'email',
              'https://www.googleapis.com/auth/contacts.readonly',
            ]);

  Future<User> signInWithGoggle() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result =
        await _firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;
    UserModel newUser = UserModel(
        id: userDetails!.uid,
        email: userDetails.email,
        displayName: userDetails.displayName,
        imgUrl: userDetails.photoURL);
    _repository.registerUser(newUser);
    return userDetails;
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('NO user');
      } else if (e.code == 'wrong-password') {
        print('wrong pass');
      }
    }
  }

  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel> getUser() async {
    var firebaseUser =  _firebaseAuth.currentUser;
    var user = await _repository.getUser(firebaseUser!.uid);
    if (user == null) {
      user = UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email,
          displayName: firebaseUser.displayName,
          imgUrl:
              'https://9mobi.vn/cf/images/ba/2018/4/16/anh-avatar-dep-1.jpg');
      _repository.registerUser(user);
    }
    return user;
  }

  Future<bool> isSignIn() async {
    return  _firebaseAuth.authStateChanges()== null;
  }

  Future signOut() async {

    Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }
}

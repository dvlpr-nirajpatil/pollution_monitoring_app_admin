import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends ChangeNotifier {
  Future<UserCredential?> userSignIn({email, pass}) async {
    UserCredential? user;
    try {
      user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    return user;
  }
}

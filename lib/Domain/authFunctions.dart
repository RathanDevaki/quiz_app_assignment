import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/user_models.dart';

signUp(String username, String emailAddress, String password) async {
  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    )
        .then((value) {
      postDetails(username);
    });
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

Future<bool> signIn(String emailAddress, String password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      log('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      log('Wrong password provided for that user.');
    }
    return false;
  }
}

postDetails(String username) async {
  final _auth = FirebaseAuth.instance;

  log('inside post');

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = _auth.currentUser;
  log(user!.email.toString());
  UserModel userModel = UserModel(
    email: user.email.toString(),
    uid: user.uid,
    name: username,
  );

  await firestore.collection("users").doc(user.uid).set(userModel.toMap());
  //firestore.terminate();
}

logOut() async {
  final FirebaseAuth auth = FirebaseAuth.instance;

  await auth.signOut();
}

Future<User?> getUserLogin() async {
  User? user = FirebaseAuth.instance.currentUser;
  return user;
}

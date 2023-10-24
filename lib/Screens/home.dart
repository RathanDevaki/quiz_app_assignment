import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Domain/authFunctions.dart';
import 'dashboard.dart';
import 'sign_in.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: getUserLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return const Dashboard();
          } else {
            return const SignIn();
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

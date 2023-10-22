import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Functions/authFunctions.dart';
import '../Provider/quiz_provider.dart';
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

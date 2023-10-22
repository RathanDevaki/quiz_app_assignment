import 'package:flutter/material.dart';

import '../Screens/dashboard.dart';
import '../Screens/quizScreen.dart';
import '../Screens/result.dart';
import '../Screens/sign_in.dart';
import '../Screens/sign_up.dart';

class MyRouter {
  Map<String, WidgetBuilder> routes = {
    '/dashboard': (context) => Dashboard(),
    '/quizScreen': (context) => QuizScreen1(),
    '/resultScreen': (context) => ResultScreen(),
    '/signIn': (context) => const SignIn(),
    '/signUp': (context) => SignUp(),
  };

  void pushToDashboard(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  void pushToSignIn(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/signIn');
  }

  void pushToSignUp(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/signUp');
  }

  void pushToResult(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/resultScreen');
  }

  void pushToQuizScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/quizScreen');
  }
}

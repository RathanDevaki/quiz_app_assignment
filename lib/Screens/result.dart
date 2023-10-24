import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_assignment/Components/appbar.dart';
import 'package:quiz_app_assignment/Domain/authFunctions.dart';
import 'package:quiz_app_assignment/Provider/quiz_provider.dart';
import 'package:lottie/lottie.dart';

import '../Components/constants.dart';
import '../Components/router.dart';
import '../Components/questions.dart';
import '../Models/result_model.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var selectedAnswers;

  MyRouter myRouter = MyRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // selectedAnswers = Provider.of<QuizProvider>(context).selectedAnswers;
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    selectedAnswers = quizProvider.selectedAnswers;
    int correctAnswer = _calculateTotalCorrectAnswers();
    int _totalScore = selectedAnswers.length;

    _uploadResult(correctAnswer, _totalScore);

    return Scaffold(
      appBar: CommonAppBar('Your Result'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Lottie.asset('assets/successBlue.json', repeat: false),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'You have scored',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(),
                    Text(
                      "$correctAnswer / ${selectedAnswers.length}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    quizProvider.resetQuiz();
                    myRouter.pushToDashboard(context);
                  },
                  icon: const Icon(Icons.restart_alt, size: 30),
                  label: const Text('Restart Quiz'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    quizProvider.resetQuiz();
                    logOut();
                    myRouter.pushToSignIn(context);
                  },
                  icon: const Icon(Icons.logout, size: 30),
                  label: const Text('Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _calculateTotalCorrectAnswers() {
    int correctCount = 0;
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == quizQuestions[i].correctAnswer) {
        correctCount++;
      }
    }
    return correctCount;
  }

  void _uploadResult(int correcct, int total) async {
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    ResultModel resModel = ResultModel(
      totalScore: total,
      obtainedScore: correcct,
      uid: user!.uid,
    );

    await firestore.collection("results").doc().set(resModel.toMap());
    //firestore.terminate();
  }
}

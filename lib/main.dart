import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_assignment/Functions/authFunctions.dart';
import 'package:quiz_app_assignment/Models/questions.dart';
import 'package:quiz_app_assignment/Provider/quiz_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_assignment/Screens/sign_in.dart';
import 'package:quiz_app_assignment/Screens/sign_up.dart';

import 'Components/constants.dart';
import 'Components/router.dart';
import 'Domain/firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'Models/question_model.dart';
import 'Screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.remove();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // questions = await fetchQuestionsFromFirestore();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MyRouter myRouter = MyRouter();

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => QuizProvider())],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "Google Sans",
          colorScheme: myColorScheme,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Quiz App - Niveus',
        routes: myRouter.routes,
        home: Home(),
      ),
    );
  }

  getUid() {
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    log('Inside main' + user!.uid);

    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    quizProvider.setUid = user!.uid;
  }
}

Future<List<QuizQuestion>> fetchQuestionsFromFirestore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<QuizQuestion> questions = quizQuestions;
  // [
  //   QuizQuestion(
  //     question: "Question 1: What is the capital of France?",
  //     options: ["New York", "London", "Paris", "Berlin"],
  //     correctAnswer: 2,
  //   ),
  //   QuizQuestion(
  //     question: "Question 2: What is the largest planet in our solar system?",
  //     options: ["Earth", "Mars", "Jupiter", "Venus"],
  //     correctAnswer: 2,
  //   ),
  //   QuizQuestion(
  //     question: "Question 3: What is the color of the sun?",
  //     options: ["Yellow", "Red", "Blue", "Green"],
  //     correctAnswer: 0,
  //   ),
  // ];

  try {
    QuerySnapshot querySnapshot = await firestore.collection('quiz').get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      //log('=-=-=-=-=' + data.toString());

      String question = data['question'] ?? '';
      List<String> options = List<String>.from(data['options']);
      int correctAnswer = data['correctAnswer'] ?? 0;

      QuizQuestion quizQuestion = QuizQuestion(
        question: question,
        options: options,
        correctAnswer: correctAnswer,
      );
      questions.add(quizQuestion);
      log('Val9090909090990909090' + quizQuestion.question);

      log('-=====-----===== $questions');
    }
  } catch (e) {
    print("Error fetching data: $e");
  }

  return questions;
}

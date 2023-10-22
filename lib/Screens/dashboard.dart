import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_assignment/Components/appbar.dart';
import 'package:quiz_app_assignment/Components/router.dart';

import '../Provider/quiz_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? uid;

  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUid() {
    final User? user = auth.currentUser;
    if (user == null) {
      return '';
    } else {
      return user.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        'Your Overall Performance',
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('results')
                .orderBy('obtainedScore', descending: true)
                // .where('uid', isEqualTo: 'dgWzs130n8eno1nlZuCo4qHlhdQ2')
                .snapshots(),
            builder: (context, userSnap) {
              if (userSnap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final snapData = userSnap.data!.docs;
                log(snapData.length.toString());
                return ListView.builder(
                  itemCount: snapData.length,
                  itemBuilder: (context, index) {
                    int _obtained = snapData[index]['obtainedScore'];
                    int _total = snapData[index]['totalScore'];

                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: (snapData[index]['uid'] == getUid())
                            ? Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Test $index',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(),
                                      Text(
                                        '$_obtained / $_total',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : null);
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButton(context),
    );
  }

  Widget FloatingButton(BuildContext context) {
    MyRouter myRouter = MyRouter();
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    return FloatingActionButton.extended(
      elevation: 20,
      onPressed: () {
        quizProvider.resetQuiz();
        myRouter.pushToQuizScreen(context);
      },
      label: const Text(
        'Start Quiz',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      icon: const Icon(
        Icons.draw,
        size: 32,
      ),
    );
  }
}

Widget EmptyWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 160,
          child: Image.asset('assets/norecords.png'),
        ),
        const Text(
          'No Test Results Found .!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}

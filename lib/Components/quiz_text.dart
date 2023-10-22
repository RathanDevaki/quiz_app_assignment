import 'package:flutter/material.dart';

Widget quizText() {
  return const Padding(
    padding: EdgeInsets.only(top: 40),
    child: Text(
      'Quiz App',
      style: TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 40,
        shadows: [
          Shadow(
            color: Color.fromARGB(255, 12, 62, 138),
            offset: Offset(3, 3),
            blurRadius: 8,
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  List<int?> _selectedAnswers = [null, null, null];
  String? uidProvider;

  List<int?> get selectedAnswers => _selectedAnswers;

  void set selectedAnswers(List<int?> selectedAnswers) {
    _selectedAnswers = selectedAnswers;
    notifyListeners();
  }

  void resetQuiz() {
    _selectedAnswers = [null, null, null];
    notifyListeners();
  }

  set setUid(String uid) {
    uidProvider = uid;
    notifyListeners();
  }
}

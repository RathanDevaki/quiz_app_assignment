import 'package:cloud_firestore/cloud_firestore.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

// final List<QuizQuestion> questions = [
//   QuizQuestion(
//     question: "Question 1: What is the capital of France?",
//     options: ["New York", "London", "Paris", "Berlin"],
//     correctAnswer: 2,
//   ),

// ];






// class QuizQuestion {
//   final String question;
//   final List<String> options;
//   final int correctAnswer;

//   QuizQuestion({
//     required this.question,
//     required this.options,
//     required this.correctAnswer,
//   });
// }


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

  // List<QuizQuestion> questions = await fetchQuestionsFromFirestore();

//   // Now 'questions' contains your data retrieved from Firestore.
// }


// final List<QuizQuestion> questions = [
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

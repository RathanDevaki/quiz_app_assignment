import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_assignment/Components/appbar.dart';

import '../Components/constants.dart';
import '../Components/router.dart';
import '../Models/questions.dart';
import '../Provider/quiz_provider.dart';

class QuizScreen1 extends StatefulWidget {
  @override
  _QuizScreen1State createState() => _QuizScreen1State();
}

class _QuizScreen1State extends State<QuizScreen1> {
  int _currentStep = 0;
  MyRouter myRouter = MyRouter();

  void _next() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      } else {
        myRouter.pushToResult(context);
      }
    });
  }

  void _previous() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  void tapped(int step) {
    setState(() {
      log(step.toString());
      _currentStep = step;
    });
  }

  void cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  bool _validateAnswers() {
    final selectedAnswers =
        Provider.of<QuizProvider>(context, listen: false).selectedAnswers;

    for (int? selectedAnswer in selectedAnswers) {
      if (selectedAnswer == null) {
        return false;
      }
    }
    return true;
  }

  continued() {
    if (_currentStep == 0) {
      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
    } else if (_currentStep == 1) {
      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
    } else if (_currentStep == 2) {
      if (_validateAnswers()) {
        log('Finish');
        myRouter.pushToResult(context);
      } else {
        showSnackBar(context, 'Please answer all the questions.!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    return Scaffold(
      appBar: CommonAppBar('Quiz'),
      body: Consumer(builder: (BuildContext context, value, Widget? child) {
        return Stepper(
          physics: const ScrollPhysics(),
          currentStep: _currentStep,
          onStepContinue: _next,
          onStepCancel: _previous,
          onStepTapped: (step) => tapped(step),
          controlsBuilder: controlsBuilder,
          steps: [
            for (int i = 0; i < 3; i++)
              Step(
                isActive: _currentStep >= i,
                state: _currentStep >= i + 1
                    ? StepState.complete
                    : StepState.disabled,
                title: Text(quizQuestions[i].question),
                content: Column(
                  children: [
                    for (int j = 0; j < quizQuestions[i].options.length; j++)
                      RadioListTile<int>(
                        value: j,
                        groupValue: quizProvider.selectedAnswers[i],
                        title: Text(quizQuestions[i].options[j]),
                        onChanged: (value) {
                          setState(() {
                            quizProvider.selectedAnswers[i] = value!;

                            // log(questions[i].options.toString());
                            // log(questions[i].correctAnswer.toString());
                            // log('SelANs' +
                            //     quizProvider.selectedAnswers.toString());
                          });
                        },
                      ),
                  ],
                ),
              ),
          ],
        );
      }),
    );
  }

// Stepper Controller Buttons
  Widget controlsBuilder(context, details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(fixedSize: Size(150, 40)),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Previous'),
          onPressed: () {
            cancel();
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.arrow_forward),
          label:
              (_currentStep == 2) ? const Text('Finish') : const Text('Next'),
          onPressed: () {
            continued();
          },
          style: ElevatedButton.styleFrom(fixedSize: const Size(150, 40)),
        )
      ],
    );
  }
}

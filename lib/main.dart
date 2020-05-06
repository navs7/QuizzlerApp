import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quiz_app/quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz App",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz App"),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  bool lastQues;
  bool actualAnswer;

  void checkAnswer(bool answerText) {
    actualAnswer = quizBrain.checkAnswer(answerText);
    lastQues = quizBrain.nextQuestion();

    setState(() {
      if (lastQues == true) {
        //Show Alert
        Alert(context: context, title: "Finished!", desc: "End of quiz.")
            .show();
        quizBrain.resetQuiz();
        scoreKeeper = [];
      } else {
        if (actualAnswer == true) {
          scoreKeeper.add(Icon(
            Icons.check_circle,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: FlatButton(
              color: Colors.green.shade600,
              onPressed: () {
                checkAnswer(true);
              },
              child: Text("True"),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: FlatButton(
              color: Colors.red.shade600,
              onPressed: () {
                checkAnswer(false);
              },
              child: Text("False"),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

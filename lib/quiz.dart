import 'dart:async';

import 'package:first_test/question.dart';
import 'package:first_test/quiz_timer.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  final List<Question> questions;

  const Quiz({
    Key key,
    this.questions,
  }) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  int score = 0;
  int timeLeftForCurrentQuestion = 5;

  List<Question> get questions => widget.questions;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      _onSecondPassed();
    });
  }

  _onTap(String choice) {
    setState(() {
      score += choice == questions[currentQuestionIndex].response ? 1 : 0;
      currentQuestionIndex++;
      timeLeftForCurrentQuestion = 5;
    });
  }

  _onSecondPassed() {
    timeLeftForCurrentQuestion--;
    if (timeLeftForCurrentQuestion > 0) {
      setState(() {});
    } else {
      _onNext();
    }
  }

  _onNext() {
    setState(() {
      currentQuestionIndex++;
      timeLeftForCurrentQuestion = 5;
    });
  }

  _replay() {
    setState(() {
      currentQuestionIndex = 0;
      timeLeftForCurrentQuestion = 5;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Score $score / ${questions.length}",
              style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
            ),
            SizedBox(
              height: 15,
            ),
            currentQuestionIndex >= questions.length
                ? Column(
                    children: <Widget>[
                      Text(
                        "finis",
                        style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RaisedButton(
                        child: Text("Refaire"),
                        onPressed: () {
                          _replay();
                        },
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      QuizTimer(
                        timeInSeconds: timeLeftForCurrentQuestion,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      QuestionItem(
                        question: questions[currentQuestionIndex],
                        onChoice: _onTap,
                        currentPosition: currentQuestionIndex + 1,
                        total: questions.length,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class QuestionItem extends StatelessWidget {
  final Question question;
  final Function(String choice) onChoice;
  final int currentPosition;
  final int total;

  const QuestionItem({
    Key key,
    this.question,
    this.onChoice,
    this.currentPosition,
    this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .5,
      height: MediaQuery.of(context).size.height * .5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$currentPosition / $total",
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  "What is the capital of : ${question.countryName}",
                  style: Theme.of(context).textTheme.headline,
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      Choice(
                        choice: question.possibilities[0],
                        onTap: () {
                          if (onChoice != null) {
                            onChoice(question.possibilities[0]);
                          }
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Choice(
                        choice: question.possibilities[1],
                        onTap: () {
                          if (onChoice != null) {
                            onChoice(question.possibilities[1]);
                          }
                        },
                      ),
                    ],
                  ),
                  Wrap(
                    children: <Widget>[
                      Choice(
                        choice: question.possibilities[2],
                        onTap: () {
                          if (onChoice != null) {
                            onChoice(question.possibilities[2]);
                          }
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Choice(
                        choice: question.possibilities[3],
                        onTap: () {
                          if (onChoice != null) {
                            onChoice(question.possibilities[3]);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Choice extends StatelessWidget {
  final String choice;
  final VoidCallback onTap;

  const Choice({
    Key key,
    this.onTap,
    this.choice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: RaisedButton(
        elevation: 1,
        child: Text(
          choice,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        color: Colors.white54,
        onPressed: () {
          if (onTap != null) {
            onTap();
          }
        },
      ),
    );
  }
}

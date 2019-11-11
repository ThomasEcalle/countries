import 'package:flutter/material.dart';

class QuizTimer extends StatelessWidget {
  final int timeInSeconds;

  const QuizTimer({
    Key key,
    this.timeInSeconds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          "$timeInSeconds",
          style: Theme.of(context).textTheme.display2.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

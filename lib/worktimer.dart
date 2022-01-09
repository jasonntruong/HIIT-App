import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import './workout.dart';

class WorkTimer extends StatelessWidget {
  int totaltime;
  String state;
  void Function() nextExercise;
  CountDownController cdcontroller = CountDownController();
  // Color circColor;

  bool firstExecute = true;

  WorkTimer(this.totaltime, this.state, this.nextExercise);

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: totaltime,
      initialDuration: 0,
      controller: cdcontroller,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      ringColor: Colors.white,
      fillColor: const Color.fromRGBO(83, 215, 105, 1),
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
        fontSize: 33.0,
        color: Colors.black,
      ),
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: true,
      isTimerTextShown: true,
      autoStart: true,
      onComplete: () {
        if (cdcontroller.getTime() != 0) {
          nextExercise();
        }
      },
    );
  }
}

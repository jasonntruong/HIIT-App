import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import './workout.dart';

class RestTimer extends StatelessWidget {
  int totaltime;
  void Function() nextExercise;
  CountDownController cdcontroller = CountDownController();

  bool firstExecute = true;

  RestTimer(this.totaltime, this.nextExercise);

  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: totaltime,
      initialDuration: 0,
      controller: cdcontroller,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      ringColor: Colors.white,
      fillColor: const Color.fromRGBO(20, 126, 251, 1),
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
        fontSize: 33.0,
        color: Colors.black,
      ),
      textFormat: CountdownTextFormat.S,
      isReverse: false,
      isReverseAnimation: false,
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

import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import './workout.dart';

class CircularTimer extends StatelessWidget {
  int totaltime;
  String state;
  void Function() nextExercise;
  CountDownController controller = CountDownController();

  bool firstExecute = true;

  CircularTimer(this.totaltime, this.state, this.nextExercise, this.controller);

  @override
  Widget build(BuildContext context) {
    return this.state == "WORK"
        ? CircularCountDownTimer(
            duration: totaltime,
            initialDuration: 0,
            controller: controller,
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
            isReverseAnimation: true,
            isTimerTextShown: true,
            autoStart: true,
            onStart: () => {
              if (controller.getTime() != 0) {nextExercise()}
            },
            onComplete: () => controller.start(),
          )
        : CircularCountDownTimer(
            duration: totaltime,
            initialDuration: 0,
            controller: controller,
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
            isTimerTextShown: true,
            autoStart: true,
          );
  }
}

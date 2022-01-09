import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiit_routine/topbar.dart';
import 'worktimer.dart';
import 'resttimer.dart';

class Workout extends StatefulWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WorkoutState();
  }
}

class _WorkoutState extends State<Workout> {
  late Timer _timer;
  late bool _firstExecute = true;
  late WorkTimer _ctimer = WorkTimer(_totaltime, _state, _nextExercise);
  late RestTimer _rtimer = RestTimer(_totaltime, _state, _nextExercise);

  int _exercise = 1;
  int _round = 1;
  String _state = "REST";
  int _totaltime = 0;

  var _data, _exercises, _rounds, _work, _rest;
  String _currExercise = "N/A";

  Future<void> _getJson() async {
    final String _response =
        await rootBundle.loadString('assets/exercises.json');
    _data = await json.decode(_response);
    _exercises = await _data[0]["exercises"];

    _rounds = await _data[0]["rounds"];
    _work = await _data[0]["work"];
    _rest = await _data[0]["rest"];

    print(_exercises.length);
  }

  void _nextExercise() async {
    print("HERE");

    if (_firstExecute) {
      await _getJson();
      _firstExecute = false;
    } else {
      if (_exercise == 5) {
        if (_round == 3) {
          Navigator.pop(context);
        }
        _exercise = 1;
        _round += 1;
      } else {
        _exercise += 1;
      }
    }

    setState(() {
      if (_state == "WORK") {
        _state = "REST";
        _totaltime = _rest;
      } else {
        _state = "WORK";
        _totaltime = _work;
      }
    });
    setState(() {
      _currExercise = _exercises[_exercise - 1];
      print(_state);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_firstExecute) {
      _nextExercise();
    }

    return MaterialApp(
      home: Scaffold(
        appBar: TopBar('Workout'),
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "ROUND " +
                    _round.toString() +
                    " EXERCISE " +
                    _exercise.toString(),
              ),
              Text(
                _exercises[_exercise - 1],
              ),
              _state == "WORK" ? _ctimer : _rtimer,
              (_exercise < 5)
                  ? Text("Next Exercise: " + _exercises[_exercise])
                  : const Text("REST"),
            ],
          ),
        ),
      ),
    );
  }
}

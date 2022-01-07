import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiit_routine/topbar.dart';

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

  int _exercise = 1;
  int _time = 0;
  int _round = 1;

  late final _data, _exercises, _rounds, _work, _rest;
  String _currExercise = "N/A";

  Future<void> _getJson() async {
    final String _response =
        await rootBundle.loadString('assets/exercises.json');
    _data = await json.decode(_response);
    _exercises = _data[0]["exercises"];

    _rounds = _data[0]["rounds"];
    _work = _data[0]["work"];
    _rest = _data[0]["rest"];

    print(_exercises.length);
  }

  void _nextExercise() async {
    print("HERE");

    if (_firstExecute) {
      await _getJson();
      _firstExecute = false;
    }

    setState(() {
      _currExercise = _exercises[_exercise - 1];
    });

    await _startTime(_work);
  }

  Future<void> _startTime(int stateTime) async {
    _time = stateTime;
    if (mounted) {
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer _timer) {
        if (_time > 0) {
          setState(() {
            _time -= 1;
          });
        } else {
          setState(() {
            _stopTime();
          });
        }
      });
    }
  }

  void _stopTime() async {
    setState(() {
      _timer.cancel();
      _time = 0;
      print(_exercise.toString());
      if (mounted) {
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
    });

    _nextExercise();
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
              Text(
                _time.toString(),
              ),
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

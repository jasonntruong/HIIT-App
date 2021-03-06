import 'dart:async';
import 'dart:convert';

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
  late final WorkTimer _ctimer = WorkTimer(_totaltime, _nextExercise);
  late final RestTimer _rtimer = RestTimer(_totaltime, _nextExercise);

  int _exercise = 1;
  int _round = 1;
  late String _state = "REST";
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
  }

  void _nextExercise() async {
    if (_firstExecute) {
      await _getJson();
      _firstExecute = false;
    } else {
      if (_state == "REST") {
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
    }
    print(_exercise);

    setState(() {
      if (_state == "WORK") {
        _state = "REST";
        _totaltime = _rest;
        _currExercise = "RESTING";
      } else {
        _state = "WORK";
        _totaltime = _work;
        _currExercise = _exercises[_exercise - 1];
      }
      _exercises = _data[0]["exercises"];
      print(_currExercise);
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
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _state == "WORK"
                ? <Widget>[
                    Text(
                      "ROUND " +
                          _round.toString() +
                          " EXERCISE " +
                          _exercise.toString(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(43, 45, 47, 1),
                      ),
                    ),
                    Text(_exercises[_exercise - 1],
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(43, 45, 47, 1))),
                    _ctimer,
                    const Text(
                      "Next Exercise: REST",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(43, 45, 47, 1),
                      ),
                    ),
                  ]
                : <Widget>[
                    Text(
                      "ROUND " +
                          _round.toString() +
                          " REST " +
                          _exercise.toString(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(43, 45, 47, 1),
                      ),
                    ),
                    const Text(
                      "Breathe in, breathe out",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(43, 45, 47, 1),
                      ),
                    ),
                    Text(_exercises[_exercise - 1],
                        style: TextStyle(fontSize: 0)),
                    _rtimer,
                    Text(
                      "Next Exercise: " + _exercises[_exercise - 1],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(43, 45, 47, 1),
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Workout extends StatefulWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WorkoutState();
  }
}

class _WorkoutState extends State<Workout> {
  late Timer _timer;

  int _exerciseIndex = 0;
  int _time = 0;

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

    print(_exercises[0]["exercises"].length);
  }

  void _nextExercise() async {
    setState(() {
      _currExercise = _exercises[_exerciseIndex];
    });
    _exerciseIndex += 1;
    _startTime(_work);
  }

  void _startTime(int stateTime) async {
    _time = stateTime;
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

  void _stopTime() async {
    setState(() {
      _timer.cancel();
      _time = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getJson();
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppBar(
                centerTitle: true,
                title: const Text(
                  'Workout',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            ElevatedButton(
              child: const Text("Hello"),
              onPressed: _nextExercise,
            ),
            ElevatedButton(
              child: Text("Stop"),
              onPressed: _stopTime,
            ),
            Text(_currExercise),
            Text(_time.toString()),
          ],
        ),
      ),
    );
  }
}

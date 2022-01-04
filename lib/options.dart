import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'Options',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

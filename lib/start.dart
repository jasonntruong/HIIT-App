import 'package:flutter/material.dart';

import './topbar.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: TopBar('Start'),
    ));
  }
}

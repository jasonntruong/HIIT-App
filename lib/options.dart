import 'package:flutter/material.dart';

import './topbar.dart';

class Options extends StatelessWidget {
  const Options({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: TopBar('Options'),
      ),
    );
  }
}

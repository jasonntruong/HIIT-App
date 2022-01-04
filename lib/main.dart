import 'package:flutter/material.dart';
import 'package:hiit_routine/workout.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

import './workout.dart';
import './options.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  void _openApp() async {
    await LaunchApp.openApp(
      androidPackageName: 'com.spotify.music',
      iosUrlScheme: 'spotify',
      appStoreLink:
          'https://apps.apple.com/us/app/spotify-new-music-and-podcasts/id324684580',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppBar(
                centerTitle: true,
                title: const Text(
                  'HIIT Routine',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text('START'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Workout()),
                ),
              ),
              ElevatedButton(
                child: Text('OPEN SPOTIFY'),
                onPressed: _openApp,
              ),
              ElevatedButton(
                child: Text('OPTIONS'),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Options()),
                ),
              ),
            ],
          ),
        ));
  }
}

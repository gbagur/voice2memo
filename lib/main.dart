import 'dart:html';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:audio_session/audio_session.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';

final recorder = FlutterSoundRecorder();


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavigationMenu(),
    );
  }
}

class BottomNavigationMenu extends StatefulWidget {
  @override
  _BottomNavigationMenuState createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    MemoScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice 333 Memo'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Memo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}

class MemoScreen extends StatefulWidget {
  @override
  _MemoScreenState createState() => _MemoScreenState();
}

Future record() async {
  await recorder.startRecorder(toFile: 'audio');
}

Future stop() async {
  await recorder.stopRecorder();
}

class _MemoScreenState extends State<MemoScreen> {
  bool _isPaused = true;

  void _togglePause() async {
    var status = await Permission.microphone.request();
    setState(() {
      _isPaused = !_isPaused;
    });

    if (status.isGranted) {
      if (recorder.isRecording) {
        await stop();
      } else {
        await record();
      }
    } else if (status.isDenied) {
      // Permission denied, show a message to the user
      print('Microphone permission denied');
    }
  }

  void _pressStop() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have no recordings'),
            Text(''),
            Text('Press the record button below to start!'),
          ],
        ),
      ),


      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _pressStop,
            child: Icon(Icons.stop_circle),
          ),
          SizedBox(width: 16), // Adding some spacing between the FABs
          FloatingActionButton(
            onPressed: _togglePause ,
            child: _isPaused ? Icon(Icons.circle_rounded) : Icon(Icons.pause),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Screen'),
    );



  }
}





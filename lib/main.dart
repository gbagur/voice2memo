import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';


String msg2 = "Press the record button below to start!!!";

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
        title: Text('Memo 2 Voice'),
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



class _MemoScreenState extends State<MemoScreen> {
  bool _isPaused = true;
  String msg3 = "3. ";



  void foo() async {
    final player = AudioPlayer(); // Create a player
    final duration = await player.setUrl( // Load a URL
        'https://www.myinstants.com/media/sounds/suiiiiiiiiiii.mp3'); // Schemes: (https: | file: | asset: )
    player.play(); // Play without waiting for completion
  }

  void foofile() async {
    final player = AudioPlayer(); // Create a player
    String filePath = 'sounds/test.mp3'; // Adjust the path to match your asset location

    try {
      final duration = await player.setAsset(filePath); // Use setAsset to play audio from assets
      player.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void foorec() async {
    final player = AudioPlayer(); // Create a player
    String filePath = 'sounds/test.mp3';
    final duration = await player.setFilePath(filePath);
    player.play(); // Play without waiting for completion
  }

  void _togglePause() async {
    setState(() {
      _isPaused = !_isPaused;

    foo();
    });
  }

  void _pressStop() {
    msg2 = "BBB";
    setState(() {
      msg3 = "3. CCC";
      foofile();
    });
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
            Text(msg2),
            Text(''),
            Text(msg3),
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
            onPressed: _togglePause,
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





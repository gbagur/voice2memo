import 'package:flutter/material.dart';


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

  void _togglePause() async {
    setState(() {
      _isPaused = !_isPaused;
    });
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





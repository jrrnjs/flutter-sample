import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  String email;

  Home(this.email);

  @override
  Widget build(BuildContext context) {
    return HomePage(email);
  }
}

class HomePage extends StatefulWidget {
  String email;

  HomePage(this.email);

  @override
  State createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Container(color: Colors.lime),
    Container(color: Colors.cyanAccent),
    Container(color: Colors.pinkAccent)
  ];

  void onNavigationTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home page'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onNavigationTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              title: Text('List')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            title: Text('Photo')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile')
          )
        ],
      ),
    );
  }
}

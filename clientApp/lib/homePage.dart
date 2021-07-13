import 'package:clientApp/petPage.dart';
import 'package:clientApp/profilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Color bgColor = Colors.grey[900];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      Text(
        widget.user.displayName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      PetPage(widget.user.uid),
      ProfilePage(widget.user),
    ];
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        // showSelectedLabels: true,
        // showUnselectedLabels: false,
        unselectedLabelStyle: TextStyle(fontSize: 1),
        selectedLabelStyle: TextStyle(fontSize: 20),
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 20, 20, 20),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            tooltip: "Home",
            backgroundColor: Colors.white,
            icon: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Icon(
                Icons.home,
                size: 30,
              ),
            ),
            label: '.',
          ),
          BottomNavigationBarItem(
            tooltip: "sonething",
            icon: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Icon(
                Icons.pets,
                size: 30,
              ),
            ),
            label: '.',
          ),
          BottomNavigationBarItem(
            tooltip: "Profile",
            icon: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Icon(
                Icons.person,
                size: 30,
              ),
            ),
            label: '.',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

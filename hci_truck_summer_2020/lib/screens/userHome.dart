import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/screens/UserListRequest.dart';
import 'package:truck/screens/login.dart';
import 'package:truck/screens/userLocationOnMap.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

List<Widget> optionsWidget = <Widget>[
  UserLocationScreen(),
  UserListRequestScreen(),
  LoginScreen(),
];

List<String> screenTitle = <String>['Location', 'Your Request', 'Login'];

class HomeScreenState extends State<UserHomeScreen> {
  int _selectesIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.backgroundColor,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            screenTitle[_selectesIndex],
            style: TextStyle(color: Colors.black, fontFamily: 'Poppins',
            fontSize: 16,),
          ),
          actions: <Widget>[
            Icon(
              Icons.notifications,
              color: AppConstants.buttonColor,
            ),
            SizedBox(
              width: 24.0,
            ),
          ],
        ),
        body: Center(
          child: optionsWidget[_selectesIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppConstants.buttonColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('History'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
          currentIndex: _selectesIndex,
          onTap: (index) {
            setState(() {
              _selectesIndex = index;
            });
          },
        ),
      ),
    );
  }
}

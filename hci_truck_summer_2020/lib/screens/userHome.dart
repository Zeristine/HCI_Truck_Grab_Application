import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/screens/UserListRequest.dart';
import 'package:truck/screens/error.dart';
import 'package:truck/screens/login.dart';
import 'package:truck/screens/profile.dart';
import 'package:truck/screens/userCreateRequest.dart';
import 'package:truck/screens/userLocationOnMap.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

List<String> screenTitle = <String>[
  'Create request',
  'My Requests',
  'Chats',
  'My Profile'
];

class HomeScreenState extends State<UserHomeScreen> {
  int _selectesIndex = 0;
  var settings = new ConnectionSettings(
      host: '34.87.73.5',
      port: 3306,
      user: 'root',
      password: '123@Admin',
      db: 'hci');
  var conn;
  @override
  void initState() {
    super.initState();
    addConnection();
  }

  void addConnection() async {
    conn = await MySqlConnection.connect(settings);
  }

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
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 16,
            ),
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
          child: homeScreenStack(_selectesIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black54,
          selectedItemColor: AppConstants.buttonColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('History'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('Message'),
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

Widget homeScreenStack(int index) {
  return Stack(
    children: <Widget>[
      Offstage(
        offstage: index != 0,
        child: TickerMode(
          enabled: index == 0,
          child: UserLocationScreen(),
        ),
      ),
      Offstage(
        offstage: index != 1,
        child: TickerMode(
          enabled: index == 1,
          child: UserListRequestScreen(),
        ),
      ),
      Offstage(
        offstage: index != 2,
        child: TickerMode(
          enabled: index == 2,
          child: UserCreateRequestScreen(),
        ),
      ),
      Offstage(
        offstage: index != 3,
        child: TickerMode(
          enabled: index == 3,
          child: ProfileScreen(),
        ),
      ),
    ],
  );
}

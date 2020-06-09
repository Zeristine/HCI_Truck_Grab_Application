import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/screens/home.dart';
import 'package:truck/screens/profile.dart';
import 'package:truck/screens/signup.dart';

class HomeTruckScreen extends StatefulWidget {
  @override
  HomeTruckState createState() => HomeTruckState();
}

class HomeTruckState extends State<HomeTruckScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeScreenStack(index),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (int index) {
            setState(() {
              this.index = index;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Map'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ]),
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
          child: HomeScreen(),
        ),
      ),
      Offstage(
        offstage: index != 1,
        child: TickerMode(
          enabled: index == 1,
          child: SignUpScreen(),
        ),
      ),
      Offstage(
        offstage: index != 2,
        child: TickerMode(
          enabled: index == 2,
          child: ProfileScreen(),
        ),
      ),
    ],
  );
}

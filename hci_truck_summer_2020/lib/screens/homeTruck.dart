import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/screens/profile.dart';
import 'package:truck/screens/requestListTruck.dart';
import 'package:truck/screens/userLocationOnMap.dart';
import 'package:truck/constants/appConstans.dart';

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
          unselectedItemColor: Colors.black54,
          selectedItemColor: AppConstants.buttonColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
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
              icon: Icon(Icons.message),
              title: Text('Chat'),
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
          child: RequestListTruckScreen(),
        ),
      ),
      Offstage(
        offstage: index != 1,
        child: TickerMode(
          enabled: index == 1,
          child: UserLocationScreen(),
        ),
      ),
      Offstage(
        offstage: index != 2,
        child: TickerMode(
          enabled: index == 2,
          child: UserLocationScreen(),
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

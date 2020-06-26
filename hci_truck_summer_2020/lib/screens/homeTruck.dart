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

List<String> screenTitle = <String>[
  'Đơn hàng vận chuyển',
  'Chats',
  'Hồ sơ của bạn'
];

List<Widget> _optionScreen = <Widget>[
  RequestListTruckScreen(),
  UserLocationScreen(),
  ProfileScreen(),
];

class HomeTruckState extends State<HomeTruckScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          screenTitle[index],
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
      ),
      body: Center(
        child: _optionScreen[index],
      ),
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

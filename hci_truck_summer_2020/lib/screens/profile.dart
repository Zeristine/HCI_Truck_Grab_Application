import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        title: Text(
          'Your Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              profileDetail(),
              SizedBox(
                height: 24,
              ),
              profileButtonGroup(context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget profileDetail() {
  return Column(
    children: <Widget>[
      Center(
        child: Container(
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            color: Colors.blueAccent,
          ),
          child: Image.asset('assets/images/delivery-truck.png'),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'Truck 1',
        style: TextStyle(fontSize: 25.0),
      ),
      Text(
        'Truck_1@gmail.com',
        style: TextStyle(fontSize: 25.0),
      ),
    ],
  );
}

Widget profileButtonGroup(BuildContext context) {
  return Column(
    children: <Widget>[
      RaisedButton(
        onPressed: () {},
        child: Row(
          children: <Widget>[
            Icon(Icons.edit),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Edit Profile',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
      RaisedButton(
        onPressed: () {},
        child: Row(
          children: <Widget>[
            Icon(Icons.edit),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Change Password',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
      RaisedButton(
        onPressed: () {},
        child: Row(
          children: <Widget>[
            Icon(Icons.edit),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Check Delivery History',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
      RaisedButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        },
        child: Row(
          children: <Widget>[
            Icon(Icons.exit_to_app),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Log out',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    ],
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/appConstans.dart';

class MessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: messageList(),
      ),
    );
    //  body: ChatItem(),
    // );
  }
}

Widget messageList() {
  return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return chatItem();
      });
}

Widget chatItem() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        leftSection,
        SizedBox(
          width: 8,
        ),
        middleSection(),
      ],
    ),
  );
}

final leftSection = new CircleAvatar(
  backgroundImage: AssetImage('assets/images/avatar2.jpg'),
  backgroundColor: Colors.lightGreen,
  radius: 28.0,
);

Widget middleSection() {
  return Flexible(
    child: Container(
      padding: EdgeInsets.only(left: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                "Dang van Tan",
                style: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              new CircleAvatar(
                backgroundColor: AppConstants.buttonColor,
                radius: 10.0,
                child: new Text(
                  "2",
                  style: new TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: new Text(
                  "Hi whatsp? asdasd sdasd hing ajd",
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(color: Colors.grey[800]),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 2, left: 8),
                child: new Text(
                  "9:50 AM",
                  style: new TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

final rightSection = new Container(
  child: new Column(
    //mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      SizedBox(
        height: 16.0,
      ),
      new Text(
        "9:50",
        style: new TextStyle(color: Colors.grey[600], fontSize: 12.0),
      ),
    ],
  ),
);

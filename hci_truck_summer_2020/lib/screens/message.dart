import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: messageList());
    //  body: ChatItem(),
    // );
  }
}

Widget messageList() {
  return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return ChatItem();
      });
}

class ChatItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Container(
          padding: EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              leftSection,
              middleSection,
              Spacer(),
              rightSection
            ],
          ),
        ),
      ],
    );
  }

  final leftSection = new Container(
    height: 50,
    child: new CircleAvatar(
      backgroundImage: AssetImage('assets/images/avatar2.jpg'),
      backgroundColor: Colors.lightGreen,
      radius: 24.0,
    ),
  );

  final middleSection = new Container(
    padding: new EdgeInsets.only(left: 8.0),
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          "Name",
          style: new TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        new Text(
          "Hi whatsp?",
          style: new TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );

  final rightSection = new Container(
    child: new Column(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Text(
          "9:50",
          style: new TextStyle(color: Colors.lightGreen, fontSize: 12.0),
        ),
        new CircleAvatar(
          backgroundColor: Colors.lightGreen,
          radius: 10.0,
          child: new Text(
            "2",
            style: new TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        )
      ],
    ),
  );
}

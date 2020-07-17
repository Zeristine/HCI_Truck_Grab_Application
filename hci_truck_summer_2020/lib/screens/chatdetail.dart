import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/models/messageModel.dart';
import 'package:truck/screens/chatdetailAppBar.dart';
import 'package:truck/services/chatbubble.dart';

enum MessageType {
  Sender,
  Reciever,
}

class ChatDetailPage extends StatelessWidget {
  final List<ChatMessage> chatMessage = [
    ChatMessage(
        message:
            "Hi Lợiasdasdasdaaaaaaaaaasdasdasdaczxczxcsadshasdhkjashdkjahskjdhakjs",
        type: MessageType.Reciever),
    ChatMessage(
        message: "Hi Lợi hghg j jkk jk j kjk jkjkjkjkj ",
        type: MessageType.Reciever),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(
        message: "Hi Lợi ádas dasd asds das adas dasd asdas dasd",
        type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
  ];
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: ChatDetailAppBar(),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 72),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ChatBubble(chatMessage: chatMessage[index]);
              },
              itemCount: chatMessage.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: BouncingScrollPhysics(),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 21),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                              hintText: "Type Message...",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              border: InputBorder.none)))
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0.0, 10, 25),
              height: 40,
              child: FloatingActionButton(
                onPressed: null,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 21,
                ),
                backgroundColor: Colors.pink,
              ),
            ),
          )
        ],
      ),
    );
  }
}

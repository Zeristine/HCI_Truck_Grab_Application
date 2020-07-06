import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/models/messageModel.dart';
import 'package:truck/screens/chatdetail.dart';

class ChatBubble extends StatefulWidget {
  final ChatMessage chatMessage;
  ChatBubble({@required this.chatMessage});

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.type == MessageType.Reciever
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .8,
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: (widget.chatMessage.type == MessageType.Reciever
                ? Colors.white
                : Colors.grey.shade200),
          ),
          child: Text(widget.chatMessage.message),
        ),
      ),
    );
  }
}

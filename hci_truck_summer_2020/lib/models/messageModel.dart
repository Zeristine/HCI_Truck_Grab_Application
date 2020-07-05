import 'package:flutter/material.dart';
import 'package:truck/models/user.dart';
import 'package:truck/models/userMessage.dart';
import 'package:truck/screens/chatdetail.dart';
import 'package:truck/screens/message.dart';


class ChatMessage {
  String message;
  MessageType type;
  ChatMessage({@required this.message,@required this.type});

}
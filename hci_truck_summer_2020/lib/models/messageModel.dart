import 'package:truck/models/user.dart';
import 'package:truck/models/userMessage.dart';

class Message {
  final UserMessage sender;
  final String time;
  final String text;

  Message(this.sender, this.time, this.text);

final UserMessage currentUser = UserMessage(
  id: 0, 
  name: 'Current User', 
  imageUrl: '');
  final UserMessage james = UserMessage(
  id: 0, 
  name: 'james', 
  imageUrl: '');

}
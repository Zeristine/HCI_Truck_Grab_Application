

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/models/messageModel.dart';
import 'package:truck/screens/chatdetailAppBar.dart';
import 'package:truck/services/chatbubble.dart';

enum MessageType {
  Sender,
  Reciever,
}

class ChatDetailPage  extends StatelessWidget{
  List<ChatMessage> chatMessage = [
    ChatMessage(message: "Hi Lợiasdasdasdaaaaaaaaaasdasdasdaczxczxcsadshasdhkjashdkjahskjdhakjs", type: MessageType.Reciever),
    ChatMessage(message: "Hi Lợi", type: MessageType.Reciever),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
    ChatMessage(message: "Hi Lợi", type: MessageType.Sender),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: ChatDetailAppBar(),
      body: Stack(
        children: <Widget>[
          ListView.builder(itemBuilder: (context, index) {
            return ChatBubble(chatMessage: chatMessage[index]);
          },
          itemCount: chatMessage.length,shrinkWrap: true,
          padding: EdgeInsets.only(top:10,bottom:10),
          physics: NeverScrollableScrollPhysics(),),
          Align(
            alignment: Alignment.bottomLeft,
             child: Container(
               padding: EdgeInsets.only(left: 16,bottom: 10),
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
                     child: Icon(Icons.add,color: Colors.white,size:21),
                       
                   ),
                   SizedBox(width: 16,),
                   Expanded(child: TextField(
                     decoration: InputDecoration(
                       hintText: "Type Message...",
                       hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none
                     )
                   ))
                   
                 ],
               ),
             ) ,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(left: 30,bottom: 50),
              child: FloatingActionButton(onPressed: null,
              child: Icon(Icons.send,color: Colors.white,),
              backgroundColor: Colors.pink,),
               
            
            ),
          )
        ],),
    );
  }

}
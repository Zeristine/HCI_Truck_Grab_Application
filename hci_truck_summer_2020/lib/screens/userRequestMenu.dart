import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/screens/UserListRequest.dart';

class RequestMenu extends StatefulWidget {
  RequestMenu({Key key}) : super(key: key);

  @override
  _requestMenuState createState() => _requestMenuState();
}

class _requestMenuState extends State<RequestMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(labelColor: Colors.grey[800], tabs: [
            Tab(
              text: "Chờ báo giá",
            ),
            Tab(
              text: "Đang vận chuyển",
            ),
            Tab(
              text: "Hoàn thành",
            ),
          ]),
          body: TabBarView(children: [
            UserListRequestScreen(1),
            UserListRequestScreen(2),
            UserListRequestScreen(3),
          ]),
        ),
      ),
    );
  }
}

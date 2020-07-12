import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/screens/UserListRequest.dart';
import 'package:truck/screens/userCreateRequest.dart';

class RequestMenu extends StatefulWidget {
  RequestMenu({Key key}) : super(key: key);

  @override
  RequestMenuState createState() => RequestMenuState();
}

class RequestMenuState extends State<RequestMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserCreateRequestScreen(),
              ));
            },
            child: Icon(Icons.add),
          ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/models/user.dart';
import 'package:truck/services/HttpService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverRequestDetailScreen extends StatefulWidget {
  final Request request;
  DriverRequestDetailScreen(this.request);
  @override
  DriverRequestDetailState createState() => DriverRequestDetailState(request);
}

class DriverRequestDetailState extends State<DriverRequestDetailScreen> {
  Request request;
  User user;
  DriverRequestDetailState(this.request);

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await HttpService.getUser(prefs.getString('userId')).then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppConstants.backgroundColor,
        title: Text(
          'Chi tiết đơn hàng',
          style: TextStyle(
            fontSize: AppConstants.minFontSize,
            color: Colors.grey[800],
            fontWeight: FontWeight.normal,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomSheet: user != null
          ? driverRequestDetailButtonGroup(request, user)
          : Container(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          child: ListView(
            children: <Widget>[
              Card(
                margin: EdgeInsets.fromLTRB(24, 12, 24, 0),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //Color.fromRGBO(236, 126, 114, 1)
                color: Color(0xff8d08cf),
                child: header(request),
              ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                margin: EdgeInsets.fromLTRB(24, 12, 24, 0),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //Color.fromRGBO(236, 126, 114, 1)
                color: Colors.white,
                child: owner(request),
              ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                margin: EdgeInsets.fromLTRB(24, 12, 24, 0),
                elevation: 3.0,
                shadowColor: Color(0xff8d08cf),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //Color.fromRGBO(236, 126, 114, 1)
                color: Colors.white,
                child: reciever(request),
              ),
              SizedBox(
                height: 250.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget header(Request request) {
  return Container(
    padding: EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          // '#' + request.requestId.toString() + ' - ' + request.commodityName,
          '#2345 - Xe máy SH',
          style: TextStyle(
            fontSize: AppConstants.medFontSize,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.donut_small),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'Khối lượng\n' + request.weight.toString() + ' tấn',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.access_time),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'Ngày hết hạn\n' + request.validDate.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.note),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Text(
                'Ghi chú\n' + request.note.toString(),
                softWrap: true,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget owner(Request request) {
  String address = request.commodityOwner.address.streetName.toString() +
      "," +
      request.commodityOwner.address.places[2].name +
      "," +
      request.commodityOwner.address.places[1].name +
      "," +
      request.commodityOwner.address.places[0].name;
  return Container(
    padding: EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Thông tin chủ hàng',
          style: TextStyle(
            fontSize: AppConstants.medFontSize,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.person),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'Họ và tên\n' + request.reciver.fullName,
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.phone),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'Số điện thoại\n' + request.reciver.phoneNumber,
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.location_on),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Text(
                'Địa Chỉ\n' + address,
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget reciever(Request request) {
  String address = request.reciver.address.streetName.toString() +
      "," +
      request.reciver.address.places[2].name +
      "," +
      request.reciver.address.places[1].name +
      "," +
      request.reciver.address.places[0].name;
  return Container(
    padding: EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Thông tin người nhận',
          style: TextStyle(
            fontSize: AppConstants.medFontSize,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.person),
            SizedBox(
              width: 8.0,
            ),
            Text('Họ và tên\n' + request.reciver.fullName),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.phone),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'Số điện thoại\n' + request.reciver.phoneNumber,
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.location_on),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Text(
                'Địa Chỉ\n' + address,
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget driverRequestDetailButtonGroup(Request request, User user) {
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[400],
            offset: Offset(0, -3),
            blurRadius: 5.0,
            spreadRadius: .3,
          )
        ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Người tạo đơn',
          style: TextStyle(
            fontSize: AppConstants.medFontSize,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 32,
              backgroundImage: user.imagePath == null
                  ? AssetImage('assets/images/no-avatar.png')
                  : NetworkImage(user.imagePath),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text(
              // user.fullName == null || user.fullName == 'Empty'
              //     ? user.userId
              //     : user.fullName,
              'Nguyen Van Loi',
              style: TextStyle(fontSize: AppConstants.minFontSize),
            ),
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          children: <Widget>[
            Container(
              height: 48,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppConstants.buttonColor,
              ),
              child: Center(
                child: Text('Nhắn tin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppConstants.minFontSize,
                    )),
              ),
            ),
            Spacer(),
            Container(
              height: 48,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppConstants.buttonColor,
              ),
              child: Center(
                child: Text('Gọi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppConstants.minFontSize,
                    )),
              ),
            ),
            Spacer(),
            Container(
              height: 48,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.green,
              ),
              child: Center(
                  child: Text('Báo giá',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppConstants.minFontSize,
                      ))),
              // IconButton(
              //   icon: Icon(Icons.check),
              //   disabledColor: Colors.white,
              //   color: Colors.white,
              //   onPressed: null,
              //   iconSize: 20.0,
            ),
          ],
        ),
      ],
    ),
  );
}

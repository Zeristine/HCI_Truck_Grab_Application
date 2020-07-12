import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Request.dart';

class DriverRequestDetailScreen extends StatefulWidget {
  final Request request;
  DriverRequestDetailScreen(this.request);
  @override
  DriverRequestDetailState createState() => DriverRequestDetailState(request);
}

class DriverRequestDetailState extends State<DriverRequestDetailScreen> {
  Request request;
  DriverRequestDetailState(this.request);

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
      bottomSheet: driverRequestDetailButtonGroup(request),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          child: ListView(
            children: <Widget>[
              Card(
                margin: EdgeInsets.fromLTRB(24, 12, 24, 0),
                elevation: 3.0,
                shadowColor: Color(0xff8d08cf),
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
                shadowColor: Color(0xff8d08cf),
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
                height: 150.0,
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
      children: <Widget>[
        Text(
          // '#' + request.requestId.toString() + ' - ' + request.commodityName,
          'Test',
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
            Icon(Icons.help),
            Text(
              // 'Khối lượng\n' + request.weight.toString() + ' tấn'
              'Test',
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
            Text('Họ và tên\n' + request.reciver.fullName),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.phone),
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

Widget driverRequestDetailButtonGroup(Request request) {
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
      children: <Widget>[
        Text(
          'Chủ đơn hàng',
          style: TextStyle(
            fontSize: AppConstants.medFontSize,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 64,
                backgroundImage: request.user.imagePath == null ||
                        request.user.imagePath == 'Empty'
                    ? AssetImage('assets/images/no-avatar.png')
                    : NetworkImage(request.user.imagePath),
              ),
              Text(request.user.fullName == null ||
                      request.user.fullName == 'Empty'
                  ? request.user.userId
                  : request.user.fullName),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppConstants.buttonColor,
              ),
              child: IconButton(
                icon: Icon(Icons.message),
                disabledColor: Colors.white,
                onPressed: null,
                iconSize: 20.0,
              ),
            ),
            Spacer(),
            Container(
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppConstants.buttonColor,
              ),
              child: IconButton(
                icon: Icon(Icons.phone),
                onPressed: null,
                disabledColor: Colors.white,
                color: Colors.white,
                iconSize: 20.0,
              ),
            ),
            Spacer(),
            Container(
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.green,
              ),
              child: IconButton(
                icon: Icon(Icons.check),
                disabledColor: Colors.white,
                color: Colors.white,
                onPressed: null,
                iconSize: 20.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

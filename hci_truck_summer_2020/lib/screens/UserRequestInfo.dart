import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Quotation.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/models/user.dart';
import 'package:truck/screens/UserEditRequest.dart';
import 'package:truck/services/HttpService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/services/appUi.dart';

class UserRequestInfoScreen extends StatefulWidget {
  final Request request;
  UserRequestInfoScreen(this.request);
  @override
  DriverRequestDetailState createState() => DriverRequestDetailState(request);
}

class DriverRequestDetailState extends State<UserRequestInfoScreen> {
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          child: ListView(
            children: <Widget>[
              Card(
                margin: EdgeInsets.fromLTRB(24, 8, 24, 0),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //Color.fromRGBO(236, 126, 114, 1)
                color: Color(0xff8d08cf),
                child: header(request),
              ),
              SizedBox(
                height: 8.0,
              ),
              Card(
                margin: EdgeInsets.fromLTRB(24, 8, 24, 0),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //Color.fromRGBO(236, 126, 114, 1)
                color: Colors.white,
                child: image(request, context),
              ),
              SizedBox(
                height: 8.0,
              ),
              Card(
                margin: EdgeInsets.fromLTRB(24, 8, 24, 0),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //Color.fromRGBO(236, 126, 114, 1)
                color: Colors.white,
                child: owner(request),
              ),
              SizedBox(
                height: 8.0,
              ),
              Card(
                margin: EdgeInsets.fromLTRB(24, 8, 24, 0),
                elevation: 3.0,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //Color.fromRGBO(236, 126, 114, 1)
                color: Colors.white,
                child: reciever(request),
              ),
              PrimaryButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserEditRequestScreen(
                          request: widget.request,
                        ),
                      ));
                },
                text: 'Sửa đơn hàng',
              ),
              SizedBox(
                height: 48.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget showImage(String path) {
  return Image(
    image: AssetImage(path),
    width: 520,
    height: 520,
  );
}

Widget header(Request request) {
  return Container(
    padding: EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '#' + request.requestId.toString() + ' - ' + request.commodityName,
          style: TextStyle(
            fontSize: AppConstants.medFontSize,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.donut_small,
              color: Colors.white,
            ),
            SizedBox(
              width: 12.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Khối lượng',
                  style: TextStyle(color: Colors.white),
                ),
                Text(request.weight.toString() + ' Tấn',
                    style: TextStyle(color: Colors.white))
              ],
            )
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.access_time,
              color: Colors.white,
            ),
            SizedBox(
              width: 12.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Ngày hết hạn',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(request.validDate.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ))
              ],
            )
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.note,
              color: Colors.white,
            ),
            SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Ghi chú',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    request.note.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.attach_money,
              color: Colors.white,
            ),
            SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'kích thước (m)',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '50x50x60',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget image(Request request, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hình ảnh',
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
          children: <Widget>[
            SizedBox(height: 12.0),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: showImage('assets/images/thunghang1.jpg'),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[200],
                ),
                child: Image(
                  fit: BoxFit.cover,
                  height: 64,
                  width: 64,
                  image: AssetImage('assets/images/thunghang1.jpg'),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: showImage('assets/images/thunghang1.jpg'),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[200],
                ),
                child: Image(
                  fit: BoxFit.cover,
                  height: 64,
                  width: 64,
                  image: AssetImage('assets/images/thunghang1.jpg'),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: showImage('assets/images/thunghang1.jpg'),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[200],
                ),
                child: Image(
                  fit: BoxFit.cover,
                  height: 64,
                  width: 64,
                  image: AssetImage('assets/images/thunghang1.jpg'),
                ),
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
          height: 12.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.person),
            SizedBox(
              width: 12.0,
            ),
            Text(
              'Họ và tên\n' + request.commodityOwner.fullName,
            ),
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.phone),
            SizedBox(
              width: 12.0,
            ),
            Text(
              'Số điện thoại\n' + request.commodityOwner.phoneNumber,
            ),
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.location_on),
            SizedBox(
              width: 12.0,
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
          height: 12.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.person),
            SizedBox(
              width: 12.0,
            ),
            Text('Họ và tên\n' + request.reciver.fullName),
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.phone),
            SizedBox(
              width: 12.0,
            ),
            Text(
              'Số điện thoại\n' + request.reciver.phoneNumber,
            ),
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          children: <Widget>[
            Icon(Icons.location_on),
            SizedBox(
              width: 12.0,
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

Widget quotationDialog(BuildContext context, int requestId) {
  String note;
  String price;
  return Container(
    padding: EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Báo giá',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 24.0,
        ),
        TextFormField(
          style: TextStyle(
            fontSize: AppConstants.minFontSize,
            fontFamily: 'Roboto',
          ),
          decoration: InputDecoration(
            hintText: 'Nhập giá tiền',
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.grey[400], width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: AppConstants.linkColor, width: 2.0),
            ),
          ),
          maxLines: 1,
          controller: null,
          onChanged: (value) {
            price = value;
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        TextField(
          style: TextStyle(
            fontSize: AppConstants.minFontSize,
            fontFamily: 'Roboto',
          ),
          decoration: InputDecoration(
            hintText: 'Nhập ghi chú cho chủ hàng',
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.grey[400], width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: AppConstants.linkColor, width: 2.0),
            ),
          ),
          maxLines: 5,
          controller: null,
          onChanged: (value) {
            note = value;
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        PrimaryButton(
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            String userId = preferences.getString('userId');

            Quotation quotation = new Quotation();
            quotation.quotationId = 0;
            quotation.date = DateTime.now();
            quotation.driverId = userId;
            quotation.price = double.parse(price);
            quotation.note = note;
            quotation.requestId = requestId;

            var result = await HttpService.addQuotation(quotation);
            Navigator.pop(context);
            if (result != null) {}
          },
          text: 'Xác nhận',
        ),
        SizedBox(
          height: 8.0,
        ),
        PrimaryButton(
          color: Colors.red[400],
          onPressed: () {
            Navigator.pop(context);
          },
          text: 'Hủy bỏ',
        )
      ],
    ),
  );
}

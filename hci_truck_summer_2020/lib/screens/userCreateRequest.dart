import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Address.dart';
import 'package:truck/models/CommodityOwner.dart';
import 'package:truck/models/Reciver.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/screens/inputAdress.dart';
import 'package:truck/services/HttpService.dart';
import 'package:truck/services/appUi.dart';

class UserCreateRequestScreen extends StatefulWidget {
  @override
  _UserCreateRequestScreenState createState() =>
      _UserCreateRequestScreenState();
}

class _UserCreateRequestScreenState extends State<UserCreateRequestScreen> {
  TextEditingController pickUpFieldController;
  List<DropdownMenuItem> wardListMenuItem = new List();
  CommodityOwner commodityOwner = new CommodityOwner();
  Reciver reciver = new Reciver();
  Request request = new Request();
  Widget body;

  @override
  void initState() {
    super.initState();
    body = body1();
    pickUpFieldController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 58, 58, 1),
        title: Text(
          "Tạo đơn hàng",
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      backgroundColor: AppConstants.backgroundColor,
      body: body,
    );
  }

  Widget body1() {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            pickUpWidget(context, commodityOwner),
            SizedBox(height: 24),
            targetWidget(context, reciver),
            SizedBox(height: 12),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  body = body2();
                });
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              text: "Tiếp theo",
            ),
          ],
        ),
      ),
    );
  }

  Widget body2() {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            comodityWidget(context, request),
            SizedBox(height: 24),
            PrimaryButton(
              onPressed: () async {
                Request newRequest;
                await HttpService.saveRequest(request, commodityOwner, reciver)
                    .then((value) {
                  newRequest = value;
                });
                if (newRequest != null) {
                  Navigator.pop(context);
                }
              },
              text: "Tạo đơn hàng",
            ),
            SizedBox(height: 12),
            PrimaryButton(
              color: AppConstants.buttonColorSecRed,
              onPressed: () {
                setState(() {
                  body = body1();
                });
              },
              text: "Quay lại",
            ),
          ],
        ),
      ),
    );
  }
}

Widget pickUpWidget(BuildContext context, CommodityOwner commodityOwner) {
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController ownerAdressController = new TextEditingController();
  TextEditingController ownerPhoneNo = new TextEditingController();
  return Column(
    children: <Widget>[
      SizedBox(height: 12.0),
      Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/product-owner.png"),
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              "Chủ hàng",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: AppConstants.medFontSize,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 12,
      ),
      textField(context, "Họ và tên chủ hàng", null, () async {}, (value) {
        commodityOwner.fullName = value;
      }, fullNameController, false, null, 1),
      SizedBox(
        height: 8,
      ),
      textField(context, "Số điện thoại", null, () async {}, (value) {
        commodityOwner.phoneNumber = value;
      }, ownerPhoneNo, false, null, 1),
      SizedBox(
        height: 8,
      ),
      textField(
        context,
        "Địa chỉ lấy hàng",
        Icons.navigate_next,
        () async {
          var result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddressScreen(),
            ),
          ) as Address;
          if (result != null) {
            commodityOwner.address = result;
            String address = result.streetName +
                ", " +
                result.places[0].name +
                ", " +
                result.places[1].name +
                ", " +
                result.places[2].name;

            ownerAdressController.text = address;
          }
        },
        null,
        ownerAdressController,
        true,
        null,
        1,
      ),
    ],
  );
}

Widget targetWidget(BuildContext context, Reciver reciver) {
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController reciverAdressController = new TextEditingController();
  TextEditingController reciverPhoneNoController = new TextEditingController();
  return Column(
    children: <Widget>[
      Container(
        width: double.infinity,
        child: Row(children: <Widget>[
          Image(
            image: AssetImage("assets/images/reciver.png"),
            width: 40,
            height: 40,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "Người nhận hàng",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: AppConstants.medFontSize,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ]),
      ),
      SizedBox(
        height: 12,
      ),
      textField(context, "Họ và tên người nhận hàng", null, () async {},
          (value) {
        reciver.fullName = value;
      }, fullNameController, false, null, 1),
      SizedBox(
        height: 8,
      ),
      textField(context, "Số điện thoại", null, () async {}, (value) {
        reciver.phoneNumber = value;
      }, reciverPhoneNoController, false, null, 1),
      SizedBox(
        height: 8,
      ),
      textField(context, "Địa chỉ lấy hàng", null, () async {
        var result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddressScreen(),
          ),
        ) as Address;
        if (result != null) {
          reciver.address = result;
          String address = result.streetName +
              ", " +
              result.places[0].name +
              ", " +
              result.places[1].name +
              ", " +
              result.places[2].name;

          reciverAdressController.text = address;
        }
      }, null, reciverAdressController, false, null, 1),
      SizedBox(
        height: 8,
      ),
    ],
  );
}

Widget textField(
    BuildContext context,
    String hint,
    IconData icon,
    Function() ontap,
    Function(String) onChanged,
    TextEditingController controller,
    bool readonly,
    TextInputType inputType,
    int maxLines) {
  return TextFormField(
    keyboardType: inputType == null ? TextInputType.text : inputType,
    readOnly: readonly,
    controller: controller,
    textInputAction: TextInputAction.next,
    style: TextStyle(
      fontSize: AppConstants.minFontSize,
      fontFamily: 'Roboto',
    ),
    decoration: InputDecoration(
      //labelText: 'EMAIL',
      suffixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: AppConstants.linkColor, width: 2.0),
      ),
      hintText: hint,
    ),
    maxLines: maxLines,
    //controller: emailController,
    // onFieldSubmitted: (v) {
    //   FocusScope.of(context).requestFocus(focus);
    // },
    onTap: ontap,
    onChanged: onChanged,
    validator: (text) {
      if (text.length == 0) {
        return "Xin hãy nhập email ở đây";
      } else {
        return null;
      }
    },
  );
}

Widget comodityWidget(BuildContext context, Request request) {
  TextEditingController datePickerController = new TextEditingController();
  DateTime pickedDate = DateTime.now();
  TextEditingController timePickerController = new TextEditingController();
  TimeOfDay pickedTime = TimeOfDay.now();
  TextEditingController commodityNameController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();
  return Column(
    children: <Widget>[
      SizedBox(height: 12.0),
      Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/product.png"),
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              "Thông tin hàng",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: AppConstants.medFontSize,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 12,
      ),
      textField(context, "Tên hàng", null, () async {}, (value) {
        request.commodityName = value;
      }, commodityNameController, false, null, 1),
      SizedBox(
        height: 8,
      ),
      textField(
        context,
        "Khối Lượng",
        null,
        () async {},
        (value) {
          request.weight = double.parse(value);
        },
        weightController,
        false,
        TextInputType.number,
        1,
      ),
      SizedBox(
        height: 8,
      ),
      textField(
        context,
        "Ngày hết hạn",
        Icons.calendar_today,
        () async {
          showDatePicker(
            context: context,
            initialDatePickerMode: DatePickerMode.day,
            initialDate: pickedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 1),
          ).then((value) {
            pickedDate = value;
            String date = pickedDate.day.toString() +
                "/" +
                pickedDate.month.toString() +
                "/" +
                pickedDate.year.toString();
            datePickerController.text = date;
          });
        },
        null,
        datePickerController,
        false,
        null,
        1,
      ),
      SizedBox(
        height: 8,
      ),
      textField(
        context,
        "Giờ hết hạn",
        Icons.timer,
        () async {
          showTimePicker(
            context: context,
            initialTime: pickedTime,
          ).then((value) {
            if (value != null) {
              pickedTime = value;
              String time = pickedTime.hour.toString() +
                  ":" +
                  pickedTime.minute.toString();
              timePickerController.text = time;
              if (pickedDate != null && pickedTime != null) {
                int year = int.parse(pickedDate.year.toString());
                int month = int.parse(pickedDate.month.toString());
                int day = int.parse(pickedDate.month.toString());
                int hour = int.parse(pickedTime.hour.toString());
                int minute = int.parse(pickedTime.minute.toString());
                request.validDate = DateTime(year, month, day, hour, minute);
              }
            }
          });
        },
        null,
        timePickerController,
        false,
        null,
        1,
      ),
      SizedBox(height: 12.0),
      Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/note.png"),
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              "Ghi chú",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: AppConstants.medFontSize,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 12,
      ),
      textField(
        context,
        "Mô tả hàng hoặc ghi chú cho tài xế...",
        null,
        null,
        (value) {
          request.note = value;
        },
        noteController,
        false,
        TextInputType.multiline,
        4,
      ),
    ],
  );
}

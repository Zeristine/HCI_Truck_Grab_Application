import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Address.dart';
import 'package:truck/screens/inputAdress.dart';
import 'package:truck/services/appUi.dart';

class UserCreateRequestScreen extends StatefulWidget {
  @override
  _UserCreateRequestScreenState createState() =>
      _UserCreateRequestScreenState();
}

class _UserCreateRequestScreenState extends State<UserCreateRequestScreen> {
  List<dynamic> list;
  List<dynamic> list2;

  int _districtValue;
  int _provinceValue;

  TextEditingController pickUpFieldController;

  List<DropdownMenuItem> wardListMenuItem = new List();

  @override
  void initState() {
    super.initState();
    pickUpFieldController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 58, 58, 1),
        title: Text("Tạo đơn hàng"),
      ),
      backgroundColor: AppConstants.backgroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              pickUpWidget(context, pickUpFieldController),
              SizedBox(height: 24),
              targetWidget(context),
              SizedBox(height: 12),
              PrimaryButton(
                onPressed: null,
                text: "Tiếp theo",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget pickUpWidget(BuildContext context, TextEditingController controller) {
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
      textField(context, "Họ và tên chủ hàng", null, null, null, false),
      SizedBox(
        height: 8,
      ),
      textField(context, "Số điện thoại", null, null, null, false),
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
            String address = result.streetName +
                ", " +
                result.places[0].name +
                ", " +
                result.places[1].name +
                ", " +
                result.places[2].name;

            controller.text = address;
          }
        },
        controller,
        true,
      ),
    ],
  );
}

Widget targetWidget(BuildContext context) {
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
      textField(context, "Họ và tên người nhận hàng", null, null, null, false),
      SizedBox(
        height: 8,
      ),
      textField(context, "Số điện thoại", null, null, null, false),
      SizedBox(
        height: 8,
      ),
      textField(context, "Địa chỉ lấy hàng", null, null, null, false),
      SizedBox(
        height: 8,
      ),
    ],
  );
}

Widget textField(BuildContext context, String hint, IconData icon,
    Function() ontap, TextEditingController controller, bool readonly) {
  return TextFormField(
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
    maxLines: 1,
    //controller: emailController,
    // onFieldSubmitted: (v) {
    //   FocusScope.of(context).requestFocus(focus);
    // },
    onTap: ontap,
    validator: (text) {
      if (text.length == 0) {
        return "Xin hãy nhập email ở đây";
      } else {
        return null;
      }
    },
  );
}

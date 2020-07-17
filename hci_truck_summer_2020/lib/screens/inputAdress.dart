import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Address.dart';
import 'package:truck/models/Place.dart';
import 'package:http/http.dart' as http;
import 'package:truck/services/appUi.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({Key key}) : super(key: key);

  @override
  AddressScreenState createState() => AddressScreenState();
}

class AddressScreenState extends State<AddressScreen> {
  List<Place> provinceList;
  bool _isLoaded = false;
  Place province;
  Place district;
  Place ward;

  Widget addressDetailWidget = Container();

  int _step = 1;

  TextEditingController streetFieldController;

  void getList(int index) async {
    if (provinceList == null) {
      provinceList = new List();
    }

    var response;
    if (_step == 1) {
      response = await http.get("https://thongtindoanhnghiep.co/api/city");
    } else if (_step == 2) {
      response = await http.get("https://thongtindoanhnghiep.co/api/city/" +
          provinceList[index].id.toString() +
          "/district");
    } else if (_step == 3) {
      response = await http.get("https://thongtindoanhnghiep.co/api/district/" +
          provinceList[index].id.toString() +
          "/ward");
    }

    provinceList.clear();

    if (_step == 1) {
      Map<String, dynamic> decode = json.decode(response.body);
      List list = decode["LtsItem"];
      setState(() {
        for (var i = 0; i < list.length - 1; i++) {
          var title = (list[i])["Title"];
          var id = (list[i])["ID"];
          provinceList.add(
            Place(
              id: id,
              name: title,
            ),
          );
        }
        _isLoaded = true;
      });
    } else if (_step == 4) {
      addressDetailWidget = AddressDetail();
      _isLoaded = true;
    } else {
      List<dynamic> list = List.from(json.decode(response.body));
      setState(() {
        for (var i = 0; i < list.length - 1; i++) {
          var title = (list[i])["Title"];
          var id = (list[i])["ID"];
          provinceList.add(
            Place(
              id: id,
              name: title,
            ),
          );
        }
        _isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    streetFieldController = new TextEditingController();
    getList(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 58, 58, 1),
        centerTitle: true,
      ),
      body: Visibility(
        visible: _isLoaded,
        child: provinceListWidget(),
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget provinceListWidget() {
    return Column(
      children: <Widget>[
        addressDetailWidget,
        Expanded(child: list()),
      ],
    );
  }

  Widget list() {
    return ListView.builder(
        itemCount: provinceList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              child: Container(
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.grey[350],
                    ),
                  ),
                ),
                child: Text(
                  provinceList[index].name.toString(),
                  style: TextStyle(fontSize: AppConstants.minFontSize),
                ),
              ),
              onTap: () async {
                setState(() {
                  _isLoaded = false;
                  if (_step == 1) {
                    province = Place(
                      id: provinceList[index].id,
                      name: provinceList[index].name,
                    );
                  } else if (_step == 2) {
                    district = Place(
                      id: provinceList[index].id,
                      name: provinceList[index].name,
                    );
                  } else if (_step == 3) {
                    ward = Place(
                      id: provinceList[index].id,
                      name: provinceList[index].name,
                    );
                  }
                  _step = _step + 1;
                });
                getList(index);
              });
        });
  }

  Widget AddressDetail() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(24.0),
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  spreadRadius: 0.2,
                  color: Colors.grey[400])
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "Tỉnh/Thành Phố",
                    style: TextStyle(fontSize: AppConstants.minFontSize),
                  ),
                  Spacer(),
                  Text(
                    province != null ? province.name : "",
                    style: TextStyle(fontSize: AppConstants.minFontSize),
                  )
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Quận/Huyện",
                    style: TextStyle(fontSize: AppConstants.minFontSize),
                  ),
                  Spacer(),
                  Text(
                    district != null ? district.name : "",
                    style: TextStyle(fontSize: AppConstants.minFontSize),
                  )
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Phường/Xã",
                    style: TextStyle(
                        fontSize: AppConstants.minFontSize,
                        fontFamily: "Poppins"),
                  ),
                  Spacer(),
                  Text(
                    ward != null ? ward.name : "",
                    style: TextStyle(fontSize: AppConstants.minFontSize),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  spreadRadius: 0.2,
                  color: Colors.grey[400])
            ],
          ),
          child: textField(
              context, "Đường, số nhà...", () => null, streetFieldController),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  spreadRadius: 0.2,
                  color: Colors.grey[400])
            ],
          ),
          child: PrimaryButton(
            onPressed: () {
              List<Place> list = new List();
              list.add(ward);
              list.add(district);
              list.add(province);
              String streetLine = streetFieldController.text;
              Address address = Address(places: list, streetName: streetLine);

              Navigator.pop(context, address);
            },
            text: "Lưu địa chỉ",
          ),
        ),
      ],
    );
  }
}

Widget textField(BuildContext context, String hint, Function() ontap,
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    textInputAction: TextInputAction.next,
    style: TextStyle(
      fontSize: AppConstants.minFontSize,
      fontFamily: 'Roboto',
    ),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(24.0),
      //labelText: 'EMAIL',
      filled: true,
      fillColor: Colors.white,
      suffixIcon: Icon(
        Icons.edit,
        size: AppConstants.medFontSize,
      ),
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

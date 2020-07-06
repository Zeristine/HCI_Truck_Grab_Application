import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/services/appUi.dart';
import 'package:http/http.dart' as http;

class AddressDialog extends StatefulWidget {
  final int provinceSelectedValue;
  final int districSelectedValue;

  AddressDialog({
    this.provinceSelectedValue,
    this.districSelectedValue,
  });

  @override
  AddressDialogState createState() => AddressDialogState();
}

class AddressDialogState extends State<AddressDialog> {
  int provinceSelectedValue;
  int districSelectedValue = 1;

  List<DropdownMenuItem> provinceMenuItems = new List();
  List<DropdownMenuItem> districMenuItems = new List();

  @override
  void initState() {
    super.initState();
    provinceSelectedValue = widget.provinceSelectedValue;
    districSelectedValue = 1;
    getList();
  }

  void getList() async {
    var response = await http.get("https://thongtindoanhnghiep.co/api/city");
    Map<String, dynamic> decode = json.decode(response.body);
    List list = decode["LtsItem"];
    setState(() {
      for (var i = 0; i < list.length - 1; i++) {
        var title = (list[i])["Title"];
        var id = (list[i])["ID"];
        provinceMenuItems.add(
          DropdownMenuItem(
            child: Text(title),
            value: id,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Text(
                  "Nhập địa chỉ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: AppConstants.medFontSize,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  //labelText: 'EMAIL',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: AppConstants.linkColor, width: 2.0),
                  ),
                ),
                items: provinceMenuItems,
                hint: Text("Tỉnh/Thành phố"),
                value: provinceSelectedValue,
                isExpanded: true,
                onChanged: (value) async {
                  if (value != null) {
                    var response = await http.get(
                        "https://thongtindoanhnghiep.co/api/city/" +
                            value.toString() +
                            "/district");

                    List<dynamic> list = List.from(json.decode(response.body));
                    setState(() {
                      provinceSelectedValue = value;
                    });

                    for (int i = 0; i < list.length; i++) {
                      districMenuItems.add(new DropdownMenuItem(
                        child: Text(list[i]["Title"]),
                        value: list[i]["ID"],
                      ));
                    }
                    districSelectedValue = 1;
                  }
                },
              ),
              SizedBox(
                height: 8,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  //labelText: 'EMAIL',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: AppConstants.linkColor, width: 2.0),
                  ),
                ),
                items: districMenuItems,
                hint: Text("Quận/Huyện"),
                value: districSelectedValue,
                isExpanded: true,
                onChanged: (value) {
                  districSelectedValue = value;
                },
              ),
              SizedBox(
                height: 8,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  //labelText: 'EMAIL',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        BorderSide(color: AppConstants.linkColor, width: 2.0),
                  ),
                ),
                items: provinceMenuItems,
                hint: Text("Phường/Xã"),
                value: provinceSelectedValue,
                isExpanded: true,
                onChanged: (value) {
                  provinceSelectedValue = value;
                },
              ),
              SizedBox(
                height: 8,
              ),
              PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Xác nhận",
              )
            ],
          ),
        ),
      ),
    );
  }
}

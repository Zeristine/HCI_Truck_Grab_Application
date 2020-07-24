import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Address.dart';
import 'package:truck/models/CommodityOwner.dart';
import 'package:truck/models/Reciver.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/models/user.dart';
import 'package:truck/screens/inputAdress.dart';
import 'package:truck/services/HttpService.dart';
import 'package:truck/services/appUi.dart';

class UserEditRequestScreen extends StatefulWidget {
  Request request;
  UserEditRequestScreen({this.request});
  @override
  _UserEditRequestScreenState createState() => _UserEditRequestScreenState();
}

class _UserEditRequestScreenState extends State<UserEditRequestScreen> {
  TextEditingController pickUpFieldController;
  List<DropdownMenuItem> wardListMenuItem = new List();
  CommodityOwner commodityOwner = new CommodityOwner();
  Reciver reciver = new Reciver();
  Request request = new Request();
  Widget body;
  List<CommodityOwner> defaultComodityOwners;
  bool isFirstTimes;

  File imageFile1;
  File imageFile2;
  File imageFile3;
  ImagePicker picker = ImagePicker();

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return File(pickedFile.path);
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    await HttpService.getCommodityOwner(userId, true).then(
      (value) async {
        // if (value != null && value.length > 0) {
        //   defaultComodityOwners = value;
        //   commodityOwner = defaultComodityOwners[0];
        //   isFirstTimes = false;
        // } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        commodityOwner.userId = prefs.getString('userId');
        User user = await HttpService.getUser(commodityOwner.userId);
        commodityOwner.fullName = user.fullName;
        commodityOwner.phoneNumber = user.phoneNumber;
        isFirstTimes = true;
        //}
      },
    );
    setState(() {
      body = body1();
    });
  }

  @override
  void initState() {
    super.initState();
    pickUpFieldController = new TextEditingController();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 58, 58, 1),
        title: Text(
          "Sửa đơn hàng",
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      backgroundColor: AppConstants.backgroundColor,
      body: body != null
          ? SingleChildScrollView(child: body)
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget body1() {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            pickUpWidget(context, widget.request.commodityOwner, isFirstTimes),
            SizedBox(height: 24),
            targetWidget(context, widget.request.reciver),
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
            comodityWidget(widget.request),
            SizedBox(height: 24),
            PrimaryButton(
              // onPressed: () async {
              //   var progressDialog = ProgressDialog(context,
              //       type: ProgressDialogType.Normal, isDismissible: false);
              //   Request newRequest;
              //   await progressDialog.show();
              //   await HttpService.saveRequest(request, commodityOwner, reciver)
              //       .then((value) {
              //     newRequest = value;
              //   });
              //   if (newRequest != null) {
              //     progressDialog.hide().then(
              //           (value) => {Navigator.pop(context)},
              //         );
              //   }
              // },
              text: "Sửa đơn hàng",
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

  Widget comodityWidget(Request request) {
    TextEditingController datePickerController = new TextEditingController();
    datePickerController.text = DateFormat.yMMMd().format(request.validDate);
    DateTime pickedDate = request.validDate;
    TextEditingController commodityNameController = new TextEditingController();
    commodityNameController.text = request.commodityName;
    TextEditingController weightController = new TextEditingController();
    weightController.text = request.weight.toString();
    TextEditingController noteController = new TextEditingController();
    noteController.text = request.note;

    TextEditingController wide = new TextEditingController();
    wide.text = "50";

    TextEditingController dai = new TextEditingController();
    dai.text = "50";

    TextEditingController height = new TextEditingController();
    height.text = "60";

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
        Container(
          child: Row(
            children: <Widget>[
              Flexible(
                child: textField(
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
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blueGrey[100],
                ),
                child: Text(
                  "Tấn",
                  style: TextStyle(
                    fontSize: AppConstants.minFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  child: Text(
                    "Kích thước hàng (m)",
                    style: TextStyle(
                      fontSize: AppConstants.minFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: textFieldNoIcon(
                        context,
                        "Dài",
                        () async {},
                        (value) {},
                        wide,
                        false,
                        TextInputType.text,
                        1,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text('x'),
                    SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      child: textFieldNoIcon(
                        context,
                        "Rộng",
                        () async {},
                        (value) {},
                        dai,
                        false,
                        TextInputType.text,
                        1,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text('x'),
                    SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      child: textFieldNoIcon(
                        context,
                        "Cao",
                        () async {},
                        (value) {},
                        height,
                        false,
                        TextInputType.text,
                        1,
                      ),
                    ),
                  ],
                ),
              ],
            )),
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
              if (pickedDate != null) {
                request.validDate = pickedDate;
                String date = pickedDate.day.toString() +
                    "/" +
                    pickedDate.month.toString() +
                    "/" +
                    pickedDate.year.toString();
                datePickerController.text = date;
              }
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
        Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "Ảnh mô tả",
                    style: TextStyle(
                      fontSize: AppConstants.minFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(children: <Widget>[
                  InkWell(
                    onTap: () async {
                      await pickImageFromGallery().then((value) {
                        setState(() {
                          imageFile1 = value;
                          body = body2();
                        });
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200],
                          ),
                          child: Image(
                            height: 64,
                            width: 64,
                            image: imageFile1 != null
                                ? FileImage(imageFile1)
                                : AssetImage('assets/images/add-image.png'),
                          ),
                        ),
                        Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                              iconSize: 32,
                              color: Colors.red,
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  imageFile1 = null;
                                  body = body2();
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  InkWell(
                    onTap: () async {
                      await pickImageFromGallery().then((value) {
                        setState(() {
                          imageFile2 = value;
                          body = body2();
                        });
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200],
                          ),
                          child: Image(
                            height: 64,
                            width: 64,
                            image: imageFile2 != null
                                ? FileImage(imageFile2)
                                : AssetImage('assets/images/add-image.png'),
                          ),
                        ),
                        Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                              iconSize: 32,
                              color: Colors.red,
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  imageFile2 = null;
                                  body = body2();
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  InkWell(
                    onTap: () async {
                      await pickImageFromGallery().then((value) {
                        setState(() {
                          imageFile3 = value;
                          print(imageFile3.path);
                          body = body2();
                        });
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[200],
                          ),
                          child: Image(
                            height: 64,
                            width: 64,
                            image: imageFile3 != null
                                ? FileImage(imageFile3)
                                : AssetImage('assets/images/add-image.png'),
                          ),
                        ),
                        Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                              iconSize: 32,
                              color: Colors.red,
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  imageFile3 = null;
                                  body = body2();
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                ]),
              ],
            )),
        SizedBox(
          height: 8,
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
}

Widget pickUpWidget(
    BuildContext context, CommodityOwner commodityOwner, bool isFirstTimes) {
  TextEditingController fullNameController = new TextEditingController();
  fullNameController.text = commodityOwner.fullName;
  TextEditingController ownerAdressController = new TextEditingController();
  ownerAdressController.text = commodityOwner.address.streetName +
      ", " +
      commodityOwner.address.ward +
      ", " +
      commodityOwner.address.district +
      ", " +
      commodityOwner.address.province;
  TextEditingController ownerPhoneNo = new TextEditingController();
  ownerPhoneNo.text = commodityOwner.phoneNumber;
  if (isFirstTimes == false) {
    fullNameController.text = commodityOwner.fullName;
    ownerPhoneNo.text = commodityOwner.phoneNumber;
    String address = commodityOwner.address.streetName.toString() +
        ', ' +
        commodityOwner.address.places[0].name.toString() +
        ', ' +
        commodityOwner.address.places[1].name.toString() +
        ', ' +
        commodityOwner.address.places[2].name.toString();
    ownerAdressController.text = address;
  } else {
    fullNameController.text = commodityOwner.fullName;
    ownerPhoneNo.text = commodityOwner.phoneNumber;
  }
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
            Spacer(),
            //Icon(Icons.list)
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
  fullNameController.text = reciver.fullName;
  TextEditingController reciverAdressController = new TextEditingController();
  reciverAdressController.text = reciver.address.streetName +
      ", " +
      reciver.address.ward +
      ", " +
      reciver.address.district +
      ", " +
      reciver.address.province;
  TextEditingController reciverPhoneNoController = new TextEditingController();
  reciverPhoneNoController.text = reciver.phoneNumber;
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
      textField(context, "Địa chỉ giao hàng", Icons.navigate_next, () async {
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
      }, null, reciverAdressController, true, null, 1),
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

Widget textFieldNoIcon(
    BuildContext context,
    String hint,
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

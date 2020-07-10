import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/user.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfileScreen> {
  SharedPreferences prefs;
  File imageFile;
  User user;
  ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> editProfileKey =
      GlobalKey(debugLabel: 'editProfileKey');

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  Future getUserData() async {
    prefs = await SharedPreferences.getInstance();
    user = User(
      userId: prefs.getString('userId'),
      fullName: prefs.getString('fullname'),
      phoneNumber: prefs.getString('phoneNumber'),
      gender: prefs.getString('gender'),
      dateOfBirth: prefs.getString('dateOfBirth'),
      imagePath: prefs.getString('imagePath'),
    );
  }

  void saveUserDate(User user) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.userId);
    await prefs.setString('fullname', user.fullName);
    await prefs.setString(
        'phoneNumber', user.phoneNumber == null ? "Empty" : user.phoneNumber);
    await prefs.setString(
        'gender', user.gender == null ? "Empty" : user.gender);
    await prefs.setString(
        'dateOfBirth', user.dateOfBirth == null ? "Empty" : user.dateOfBirth);
    await prefs.setInt('roleId', user.role.roleId);
    await prefs.setBool('isLoggedIn', true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: AppConstants.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppConstants.backgroundColor,
              leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text('Lưu'),
                  ),
                ),
              ],
              title: Text(
                'Chỉnh sửa Hồ sơ',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: editProfileOptions(context, imageFile, () async {
                pickImageFromGallery();
              }, user),
            ),
          );
        });
  }
}

Widget editProfileOptions(BuildContext context, File imageFile,
    Function pickImageFromGallery, User user) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        imageChoose(context, imageFile, pickImageFromGallery, user.imagePath),
        SizedBox(
          height: 24.0,
        ),
        userForm(context, user),
      ],
    ),
  );
}

Widget imageChoose(BuildContext context, File image,
    Function pickImageFromGallery, String imagePath) {
  return Container(
    height: 150.0,
    child: Center(
      child: InkWell(
        onTap: pickImageFromGallery,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: ClipRRect(
            child: CircleAvatar(
              radius: 64,
              backgroundImage: image == null
                  ? (imagePath == null
                      ? AssetImage('assets/images/user_avatar.png')
                      : (imagePath == 'Empty'
                          ? AssetImage('assets/images/user_avatar.png')
                          : NetworkImage(imagePath)))
                  : FileImage(image),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget userForm(BuildContext context, User user) {
  final TextEditingController fullnameController = TextEditingController(
    text: user.fullName == null
        ? ''
        : (user.fullName == 'Empty' ? '' : user.fullName),
  );
  final TextEditingController phoneNumberController = TextEditingController(
    text: user.phoneNumber == null
        ? ''
        : (user.phoneNumber == 'Empty' ? '' : user.phoneNumber),
  );
  final TextEditingController dateOfBirthController = TextEditingController(
    text: user.dateOfBirth == null
        ? ''
        : (user.dateOfBirth == 'Empty' ? '' : user.dateOfBirth),
  );
  return Form(
    child: Container(
      margin: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Họ và Tên',
            style: TextStyle(
              fontSize: AppConstants.medFontSize,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: fullnameController,
            style: TextStyle(
              fontSize: AppConstants.minFontSize,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
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
            maxLines: 1,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            'Số điện thoại',
            style: TextStyle(
              fontSize: AppConstants.medFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: phoneNumberController,
            style: TextStyle(
              fontSize: AppConstants.minFontSize,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
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
            maxLines: 1,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('Ngày sinh:'),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: dateOfBirthController,
            style: TextStyle(
              fontSize: AppConstants.minFontSize,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
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
            maxLines: 1,
            onTap: () {},
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('Giới tính của bạn là:'),
        ],
      ),
    ),
  );
}

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
  User userData;
  File imageFile;
  ImagePicker picker = ImagePicker();

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  void getUserData() async {
    prefs = await SharedPreferences.getInstance();
    userData = User(
      userId: prefs.getString('userId'),
      fullName: prefs.getString('fullname'),
      phoneNumber: prefs.getString('phoneNumber'),
      gender: prefs.getString('gender'),
      dateOfBirth: prefs.getString('dateOfBirth'),
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
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
        }),
      ),
    );
  }
}

Widget editProfileOptions(BuildContext context, File imageFile, Function pickImageFromGallery) {
  return Container(
    child: Column(
      children: <Widget>[
        imageChoose(context, imageFile, pickImageFromGallery),
        SizedBox(
          height: 24.0,
        ),
      ],
    ),
  );
}

Widget imageChoose(
    BuildContext context, File image, Function pickImageFromGallery) {
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
                  ? AssetImage('assets/images/user_avatar.png')
                  : FileImage(image),
            ),
          ),
        ),
      ),
    ),
  );
}

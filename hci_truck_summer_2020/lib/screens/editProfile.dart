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
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  File imageFile;

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

  void saveUserData(User user) async {
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

  void pickImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickedFile.path);
    });
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
      body: editProfileOptions(context, imageFile, () async {
        pickImageFromGallery();
      }),
    );
  }
}

Widget editProfileOptions(
    BuildContext context, File imageFile, Function pickImageFromGallery) {
  return Container(
    child: Column(
      children: <Widget>[
        imageChoose(context, imageFile, pickImageFromGallery),
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: image == null
                ? Image.asset(
                    'assets/images/user_avatar.png',
                    width: 110.0,
                    height: 110.0,
                  )
                : Image.file(
                    image,
                    width: 110.0,
                    height: 110.0,
                  ),
          ),
        ),
      ),
    ),
  );
}

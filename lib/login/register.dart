
import 'dart:convert';

import 'package:assesmentexample/preference/PreferenceHelper.dart';
import 'package:assesmentexample/home/HomePage.dart';
import 'package:assesmentexample/login/db/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/CommonWidgets.dart';
import 'db/userModel.dart';

class Registeration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterationState();
  }
}

class _RegisterationState extends State<Registeration> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _dobController = new TextEditingController();
  TextEditingController _mobileController = new TextEditingController();

  String _dobErrorText;
  String _mobileErrorText;
  String _nameErrorText;

  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Register",
              style: GoogleFonts.roboto()
                  .copyWith(fontSize: 22, color: Colors.black54),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: _buildTextField(context, "Name", _nameErrorText,
                TextInputType.text, _nameController),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: _buildTextField(context, "Age", _dobErrorText,
                TextInputType.number, _dobController),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 50),
            child: _buildTextField(context, "Mobile No.", _mobileErrorText,
                TextInputType.number, _mobileController),
          ),
          SubmitBtn("Submit", _onRegister)
        ],
      ),
    );
  }

  _buildTextField(BuildContext context, String label, String errorText,
      TextInputType type, TextEditingController controller) {
    return TextField(
        onChanged: (text) {
          setState(() {
            _dobErrorText = null;
            _mobileErrorText = null;
            _nameErrorText = null;
          });
        },
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          labelStyle: GoogleFonts.robotoMono().copyWith(
              color: Colors.black54,
              fontSize: 18,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff95959d))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff95959d))),
          errorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        ),
        style: GoogleFonts.roboto().copyWith(
            color: Colors.black54,
            fontSize: 14,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal),
        keyboardType: type);
  }

  Future<void> _onRegister() async {
    isValidName();
    isValidAge();
    isValidPhone();
    bool validEntry = (isValidAge() && isValidName() && isValidPhone());
    if (validEntry) {
      User user = new User(_nameController.text.trim(),
          int.parse(_dobController.text.trim()), _mobileController.text.trim());
      await dbHelper.saveUser(user).then((value) async {
        print(value);
        final user2 = await dbHelper.loginUser(
            _nameController.text.trim(), _mobileController.text.trim());
        await setPref(user2);
       /* Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));*/
      });
    }
  }

  void setPref(User user) async{
    LocalStorageService service = await LocalStorageService.getInstance();
    service.setLogin(true);
    print("tostring  ${user.toMap().toString()}");
    service.saveUserRegCred(user.toMap().toString());
  }

  bool isValidAge() {
    try {
      if (int.parse(_dobController.text.trim()) != null) {
        int value = int.parse(_dobController.text.trim());
        if (value < 2 || value > 100) {
          setState(() {
            _dobErrorText = "Not eligible";
          });
          return false;
        } else {
          return true;
        }
      }
    } catch (e) {
      print(e);
      setState(() {
        _dobErrorText = "Please enter valid age";
      });
      return false;
    }
  }

  bool isValidName() {
    if (_nameController.text.length <= 0) {
      setState(() {
        _nameErrorText = "Invalid Entry";
      });
      return false;
    } else
      return true;
  }

  bool isValidPhone() {
    if (_mobileController.text.trim().length != 10) {
      setState(() {
        _mobileErrorText = "Please enter valid mobile no.";
      });
      return false;
    } else
      return true;
  }
}

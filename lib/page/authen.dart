import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiprepair/models/user_model.dart';
import 'package:whiprepair/page/my_service.dart';
import 'package:whiprepair/page/register.dart';
import 'package:whiprepair/utility/my_constant.dart';
import 'package:whiprepair/utility/my_style.dart';
import 'package:whiprepair/utility/normal_dialog.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool status = true;
  bool statusLogin = true;
  String user, password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: statusLogin
          ? Center(
              child: CircularProgressIndicator(),
            )
          : buildContainer(),
    );
  }

  Container buildContainer() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1.0,
          colors: <Color>[
            Colors.white,
            MyStyle().primaryColor,
          ],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLogo(),
              buildText(),
              buildUser(),
              buildPassword(),
              buildRaisedButton(),
              buildFlatButton()
            ],
          ),
        ),
      ),
    );
  }

  FlatButton buildFlatButton() => FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Register(),
              ));
        },
        child: Text('New Register'),
      );

  Container buildRaisedButton() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: RaisedButton(
          color: MyStyle().darkColor,
          onPressed: () {
            print('user = $user, password = $password');
            if (user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'Please Fill Every Blank');
            } else {
              checkAuthentication();
            }
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          labelStyle: TextStyle(color: MyStyle().darkColor),
          labelText: 'User :',
          prefixIcon: Icon(
            Icons.account_box,
            color: MyStyle().darkColor,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  //Test

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: status,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: MyStyle().darkColor,
              ),
              onPressed: () {
                setState(() {
                  status = !status;
                });
              }),
          labelStyle: TextStyle(color: MyStyle().darkColor),
          labelText: 'Password :',
          prefixIcon: Icon(
            Icons.lock,
            color: MyStyle().darkColor,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Text buildText() => Text(
        'Whip Repair',
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple[700],
                fontStyle: FontStyle.italic)),
      );

  Container buildLogo() {
    return Container(
      width: 120,
      child: Image.asset('images/logo.png'),
    );
  }

  Future<Null> checkPreferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('User') != null) {
      moveToService();
    } else {
      setState(() {
        statusLogin = false;
      });
    }
  }

  void moveToService() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MyService(),
        ),
        (route) => false);
  }

  Future<Null> checkAuthentication() async {
    String url =
        '${MyConstant().domain}/tisi/getUserWhereUser.php?isAdd=true&User=$user';
    await Dio().get(url).then((value) {
      if (value.toString() == 'null') {
        normalDialog(context, 'No $user in my Database');
      } else {
        var result = json.decode(value.data);
        for (var json in result) {
          UserModel model = UserModel.fromJson(json);
          if (password == model.password) {
            savePreferance(model);
          } else {
            normalDialog(context, 'Password False Please Try Again');
          }
        }
      }
    });
  }

  Future<Null> savePreferance(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('key', value)
  }
}

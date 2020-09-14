import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:whiprepair/utility/my_constant.dart';
import 'package:whiprepair/utility/my_style.dart';
import 'package:whiprepair/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String positionChoose, name, user, password;
  bool result = true; //true หมายถึง User มีในฐานข้อมูลแล้ว
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('name = $name, user = $user, password =$password');
          if (name == null ||
              name.isEmpty ||
              user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, 'มีช่องว่าง ค่ะ ? กรุณารอกทุกช่อง ค่ะ');
          } else {
            checkUser();
          }
        },
        child: Icon(Icons.cloud_upload),
      ),
      appBar: AppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                buildName(),
                buildUser(),
                buildPassword(),
                buildPosition(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildPosition() => Container(
        margin: EdgeInsets.only(top: 32),
        width: 280,
        child: DropdownButton(
          value: positionChoose,
          items: MyConstant()
              .positions
              .map(
                (e) => DropdownMenuItem(
                  child: Container(
                    width: 250,
                    child: Text(e),
                  ),
                  value: e,
                ),
              )
              .toList(),
          hint: Text('โปรดเลือกตำแหน่ง'),
          onChanged: (value) {
            setState(() {
              positionChoose = value;
            });
          },
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

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          labelStyle: TextStyle(color: MyStyle().darkColor),
          labelText: 'Passoword :',
          prefixIcon: Icon(
            Icons.lock,
            color: MyStyle().darkColor,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 64),
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          labelStyle: TextStyle(color: MyStyle().darkColor),
          labelText: 'Display Name :',
          prefixIcon: Icon(
            Icons.fingerprint,
            color: MyStyle().darkColor,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<Null> checkUser() async {
    String url =
        '${MyConstant().domain}/tisi/getUserWhereUserMaster.php?isAdd=true&User=$user';

    Response response = await Dio().get(url);
    if (response.toString() == 'null') {
      if (positionChoose == null) {
        normalDialog(context, 'Please Choose Position');
      } else {
        registerProcess();
      }
    } else {
      normalDialog(context, 'User Dulicate');
    }
  }

  Future<Null> registerProcess() async {
    String url =
        'http://b4c61a562f32.ngrok.io/tisi/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&Position=$positionChoose';
    Response response = await Dio().get(url);
    if (response.toString() == 'true') {
      Navigator.pop(context);
    } else {
      normalDialog(context, 'Please Try Againg');
    }
  }
}

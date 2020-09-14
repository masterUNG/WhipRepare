import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whiprepair/page/register.dart';
import 'package:whiprepair/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          onPressed: () {},
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
}

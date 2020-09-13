import 'dart:async';
import 'package:flutter/material.dart';
import 'package:soqya/models/global.dart';
import 'package:soqya/models/order.dart';

//import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:url_launcher/url_launcher.dart';

Order _Order = Order('', '', '', '', '');
bool _is = false;

class CallUs extends StatefulWidget {
  @override
  _CallUsState createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff2fa4e0), title: Text(
        'اتصل بنا',
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'GE-Dinar_One_Medium'),
      ),),
      backgroundColor: Colors.white,
      body:  Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Image.asset(
              'assets/logo2.jpg',
              height: 150,
            ),
            Container(
              padding: EdgeInsets.all(1),
              height: 60,
              margin: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal[50]),
              child: ListTile(
                onTap: () {
                  launch("tel://555316575");
                },
                title: Text(
                  'الرقم المجاني',
                  style: TextStyle(
                      color: Color(0xff003d7f),
                      fontSize: 16,
                      fontFamily: ''),
                ),
                trailing: Icon(
                  Icons.call,
                  color: Color(0xff003d7f),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(1),
              height: 60,
              margin: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal[50]),
              child: ListTile(
                onTap: () {
                  launch("whatsapp://send?phone=+966555316575");
                },
                title: Text(
                  'وتس اب',
                  style: TextStyle(
                      color: Color(0xff003d7f),
                      fontSize: 16,
                      fontFamily: ''),
                ),
                trailing: Icon(
                  Icons.call,
                  color: Color(0xff003d7f),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(1),
              height: 60,
              margin: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal[50]),
              child: ListTile(
                onTap: () {
                  launch("mailto:deve.ahmedramadan@gmail.com?subject=From Soqya App");
                },
                title: Text(
                  'البريد الالكتروني',
                  style: TextStyle(
                      color: Color(0xff003d7f),
                      fontSize: 16,
                      fontFamily: ''),
                ),
                trailing: Icon(
                  Icons.call,
                  color: Color(0xff003d7f),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(1),
              height: 60,
              margin: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal[50]),
              child: ListTile(
                onTap: () {
                  launch("tel://+96614863444");
                },
                title: Text(
                  'وزارة البيئة والمياة والزراعة',
                  style: TextStyle(
                      color: Color(0xff003d7f),
                      fontSize: 16,
                      fontFamily: ''),
                ),
                trailing: Icon(
                  Icons.call,
                  color: Color(0xff003d7f),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(1),
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal[50]),
              child: ListTile(
                onTap: () {
                  launch("tel://+96614863444");
                },
                title: Text(
                  'شيب العزيزية',
                  style: TextStyle(
                      color: Color(0xff003d7f),
                      fontSize: 16,
                      fontFamily: ''),
                ),
                trailing: Icon(
                  Icons.call,
                  color: Color(0xff003d7f),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(1),
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal[50]),
              child: ListTile(
                onTap: () {
                  launch("tel://+96614863444");
                },
                title: Text(
                  'شيب الجرف',
                  style: TextStyle(
                      color: Color(0xff003d7f),
                      fontSize: 16,
                      fontFamily: ''),
                ),
                trailing: Icon(
                  Icons.call,
                  color: Color(0xff003d7f),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(1),
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal[50]),
              child: ListTile(
                onTap: () {
                  launch("tel://+96614863444");
                },
                title: Text(
                  'شيب شرق وحى المطار',
                  style: TextStyle(
                      color: Color(0xff003d7f),
                      fontSize: 16,
                      fontFamily: ''),
                ),
                trailing: Icon(
                  Icons.call,
                  color: Color(0xff003d7f),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(1),
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal[50]),
              child: ListTile(
                onTap: () {
                  launch("tel://+96614863444");
                },
                title: Text(
                  'شيب المحاميد',
                  style: TextStyle(
                      color: Color(0xff003d7f),
                      fontSize: 16,
                      fontFamily: ''),
                ),
                trailing: Icon(
                  Icons.call,
                  color: Color(0xff003d7f),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

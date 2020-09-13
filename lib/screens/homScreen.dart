import 'dart:async';
import 'dart:io';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:soqya/models/global.dart';
import 'package:soqya/screens/complain.dart';
import 'package:soqya/screens/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var selectedMenuItemId;

  @override
  void initState() {
    super.initState();
    selectedMenuItemId = 'home';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Color(0xff2fa4e0),
          child: ListView(
            children: <Widget>[
              Container(
                height: 70,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: Image.asset(
                    'assets/home.png',
                    height: 20,
                  ),
                  title: Text(
                    'الرئيسية',
                    style: TextStyle(
                      color: Color(0xffefefef),
                      fontSize: 16,
                      fontFamily: 'GE-Dinar_One_Medium',
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/Profile');
                  },
                  leading: Image.asset(
                    'assets/profile.png',
                    height: 20,
                  ),
                  title: Text(
                    'الملف الشخصي',
                    style: TextStyle(
                      color: Color(0xffefefef),
                      fontSize: 16,
                      fontFamily: 'GE-Dinar_One_Medium',
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/AboutUs');
                  },
                  leading: Image.asset(
                    'assets/aboutus.png',
                    height: 20,
                  ),
                  title: Text(
                    'من نحن',
                    style: TextStyle(
                      color: Color(0xffefefef),
                      fontSize: 16,
                      fontFamily: 'GE-Dinar_One_Medium',
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: ListTile(
                  onTap: () {
                    //launch("tel://+96614863444");
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/CallUs');
                  },
                  leading: Image.asset(
                    'assets/contact.png',
                    height: 20,
                  ),
                  title: Text(
                    'اتصل بنا',
                    style: TextStyle(
                      color: Color(0xffefefef),
                      fontSize: 16,
                      fontFamily: 'GE-Dinar_One_Medium',
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => Complain()));
                  },
                  leading: Icon(
                    Icons.comment,
                    color: Colors.white,
                  ),
                  title: Text(
                    'ارسال شكاوى',
                    style: TextStyle(
                      color: Color(0xffefefef),
                      fontSize: 16,
                      fontFamily: 'GE-Dinar_One_Medium',
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/AboutDeveloper');
                  },
                  leading: Image.asset(
                    'assets/developer.png',
                    height: 20,
                  ),
                  title: Text(
                    'عن المطور',
                    style: TextStyle(
                      color: Color(0xffefefef),
                      fontSize: 16,
                      fontFamily: 'GE-Dinar_One_Medium',
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                child: ListTile(
                  onTap: () {
                    _logOut(context);
                  },
                  leading: Image.asset(
                    'assets/out1.png',
                    height: 20,
                  ),
                  title: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                      color: Color(0xffefefef),
                      fontSize: 16,
                      fontFamily: 'GE-Dinar_One_Medium',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff2fa4e0),
        title: Text(
          'سقيا المدينة',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'GE-Dinar_One_Medium'),
        ),
      ),
      body: home(context),
    );
  }
}

_logOut(context) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove('email');
  preferences.remove('password');
  preferences.remove('token');
  preferences.remove('isLogin');
  preferences.remove('orderN');
  preferences.remove('orderI');
  preferences.remove('orderF');
  preferences.setBool('isLogin', false);
  Navigator.pushReplacementNamed(context, '/Login');
}

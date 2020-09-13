import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mySlider.dart';

Widget home(context) {
  var _images = [
    'assets/img1.jpg',
    'assets/img2.jpeg',
  ];
  return SingleChildScrollView(
      child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            HomeSlider(),
            Container(
              height: 50,
              margin: EdgeInsets.only(
                  top: 20,),
              decoration: BoxDecoration(
                  color: Color(0xffefefef),
                  ),
              alignment: Alignment(0, 0),
              child: Text(
                "خدماتنا",
                style: TextStyle(
                  fontFamily: 'GE-Dinar_One_Medium',
                  color:Color(0xff2fa4e0),
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _item(0, context),
              SizedBox(
                width: 20,
              ),
              _item(1, context),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _item(int id, context) {
  return InkWell(
    onTap: () {
      if (id != 0) {
        Navigator.of(context).pushNamed('/MyOrder');
      } else {
        Navigator.of(context).pushNamed('/NewOrder');
      }
    },
    child: Container(
      width: MediaQuery.of(context).size.width/1.5,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color:  Color(0xffefefef),
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              id == 0 ? 'assets/add_order.png' : 'assets/myOrder.png',
              height: MediaQuery.of(context).size.height / 8,
            ),
            SizedBox(width: 10,),
            Text(
              id == 0 ? 'اضافة طلبية' : "طلباتي",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mj_Dinar_Two_Light',
                  color:Color(0xff2fa4e0),
                  fontSize: MediaQuery.of(context).size.height / 40),
            ),
          ],
        )),
  );
}

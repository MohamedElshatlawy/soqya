import 'package:flutter/material.dart';

bool connected = false;
Color textColor = Color(0xff009EDE); // Color(0xff91D4F1);
String textFont = 'Regular'; // Color(0xff91D4F1);
//const domain = 'http://192.168.1.54/soqya';
const domain = 'http://ilc.ruu.mybluehost.me/mysoqya';

Future<void> ackAlert({BuildContext context, String title, String content}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text('نعم'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget myCircularProgressIndicator() {
  return Center(
      child: CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(textColor),
  ));
}

Future<void> notConnected({BuildContext context}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('واي فاي'),
            Icon(
              Icons.signal_wifi_off,
            ),
          ],
        ),
        content: Text(''),
        actions: <Widget>[
          FlatButton(
            child: Text('نعم'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> done({BuildContext context}) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'تم عمل الحساب بنجاح ..... \n الرجاء التواصل مع خدمة العملة لتفعيل الحساب \n شكرا لستخدامكم التطبيق سقيا الدينة',
              style: TextStyle(fontSize: 18),
            ),
            /*  Container(
              height: 100,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 70,
              ),
            ),
            Text(
              'تم',
              style: TextStyle(color: Colors.blue, fontSize: 25),
            ),*/
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'تم',
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

progress({BuildContext context, bool isLoading}) {
  if (isLoading) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              child: Center(child: CircularProgressIndicator())),
        );
      },
    );
  } else {
    Navigator.pop(context);
  }
}

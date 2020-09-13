import 'package:soqya/models/global.dart';
import 'package:soqya/models/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:flutter/material.dart';

Order _Order = Order('', '', '', '', '');
bool _isCheckInternet = false;
bool _is = false;

class AddOrder extends StatefulWidget {
  @override
  _AddOrderState createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  List<Order> Orders = List();
  List postions = List();
  bool isClick = false;

  connection() async {
    bool con = await checkInternet();
    if (con) {
      getOrders();
      setState(() {
        _is = true;
      });
    } else {
      setState(() {
        _is = false;
      });
    }
  }

  getOrders() async {
    List<dynamic> jsonOrders = List();
    http.Response response = await http.get('$domain/api/sizes');
    if (response.statusCode == 200) {
      jsonOrders = await json.decode(response.body);
      for (var i = 0; i < jsonOrders.length; i++) {
        Map<String, dynamic> map = Map();
        map['id'] = jsonOrders[i]['id'];
        map['code'] = jsonOrders[i]['code'];
        map['ar_name'] = jsonOrders[i]['ar_name'];
        map['en_name'] = jsonOrders[i]['en_name'];
        map['price'] = jsonOrders[i]['price'];
        map['tax'] = jsonOrders[i]['tax'];
        map['total'] = jsonOrders[i]['total'];
        map['created_at'] = jsonOrders[i]['created_at'];
        map['updated_at'] = jsonOrders[i]['updated_at'];
        Order order = Order.fromJson(map);
        if (i == 0) {
          order.setClick(true);
        }
        Orders.add(order);
        postions.add(i);
      }
      _Order = Orders[0];
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    connection();
  }

  int _n = 1;

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 1) _n--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
            onTap: () {
              connection();
              setState(() {});
            },
            child: Icon(Icons.sync),
          )
        ],
        title: Text(
          "اضافة طلبية",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'GE-Dinar_One_Medium'),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10),
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Orders == null ? 0 : Orders.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _Order = Orders[index];
                      if (Orders[index].isClick) {
                      } else {
                        for (int i = 0; i < Orders.length; i++) {
                          Orders[i].setClick(false);
                          if (index == i) {
                            Orders[index].setClick(true);
                          }
                        }
                      }
                    });
                  },
                  child: card(order: Orders[index], isClick: isClick),
                );
              },
            ),
          ),
         
          Container(
            height: MediaQuery.of(context).size.height - 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Text(
                    '${_Order.ar_name == null ? '' : _Order.ar_name}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'السعر الاجمالى',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        Text(
                          '${_Order.total == null ? '' : _Order.total}',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'الضريبة',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        Text(
                          '${_Order.tax == null ? '' : _Order.tax}',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'السعر',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                        Text(
                          '${_Order.price == null ? '' : _Order.price}',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
      
      
          Container(
              margin: EdgeInsets.only(right: 20, left: 20),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  setNewOreder(order: _Order, quantity: _n);
                  ShowDialog(context: context);
                },
                color: Colors.blue,
                child: Text(
                  'تاكيد',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ))
        ],
      ),
    );
  }
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.wifi) {
    debugPrint('connected');
    
    return true;
  } else if (connectivityResult == ConnectivityResult.mobile) {
    debugPrint('connected');
    return true;
  } else {
    debugPrint('not connected');
    return false;
  }
}

setNewOreder({Order order, int quantity}) async {
  Map<String, String> body = {
    'title': order.ar_name == null ? '' : order.ar_name,
    'quantity': '$quantity',
    'size_id': '${order.id}',
  };

  http.Response response =
      await http.post('$domain/api/orders', body: body, headers: {
    "Accept": "application/json",
    "Authorization":
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjU4MWIxZjc2YTU0NjhjYjQ4OGEzZDhhMmU3YmZlNzY0YzY0ZGRmODVjMjM0ZDcwNTM5Mjg1MTNlNDNlN2YxNzdlYjlhNWE3YWFhODMzYWQzIn0.eyJhdWQiOiIxIiwianRpIjoiNTgxYjFmNzZhNTQ2OGNiNDg4YTNkOGEyZTdiZmU3NjRjNjRkZGY4NWMyMzRkNzA1MzkyODUxM2U0M2U3ZjE3N2ViOWE1YTdhYWE4MzNhZDMiLCJpYXQiOjE1NTI4MDU4OTYsIm5iZiI6MTU1MjgwNTg5NiwiZXhwIjoxNTg0NDI4Mjk2LCJzdWIiOiIzMDIiLCJzY29wZXMiOltdfQ.lOmC5pMaRFuICTvs9ScAZAjgO9z8TpF8AAOWLMkP7gEBj5TjerqjxWExsMDSJXYDUCuF6eXlwoHHXJgVg3wJbkaav9zfoYRDskC7zWaBSV8QX5VM0R-u2BT31N7qu-Rbv0NLoRTREanQoYeSICCISYUJsdNAhk-NPAXT96PxuV7SaP5UM7drd2Km2T4FTX7CSpOHfRt3_ZpO5rOsw_DE1L775yZtVGRu9Yn1ps9Glf91Kel5xIlbLGw1GZrlgY0hDmVB0tQz3a3hDoK-NevbtJZTqaCsjWywu7Qpcf7fQNRQZ9B8gD087ecOLMVRHH-qoGOnfDNHAoy0LMmqruofDkanF3vj4V28KFISP62USlZitu5f09B57qKcump5Veh7W4CugmUY3V0Ahn0M00QnIc_z1eTvtHrD6mXoh6flAmyUnl35bmw8yaio7tBNVRHanXQO5okf31i52GDozb5BmQOb5FEwdxs5zm8YHnjecEla7lTGQX4fvRW--c1YJ4kdQntmNkEeMZO45-E49DDIJbd2riPiXvK7aRSf9knP11yVyEAiGYQQQYPVCFnOtrFyGWDva1ncWvancRbJctJZTJyiWAwHFoq5TdNIEVNEJd5DlNQjcDNLtbQDxv96-2C1fsDulhae4J9T3k2pyIHMOhuIu7_FmF6-NVL209-eJg0",
  });
  debugPrint('${response.statusCode}');
  if (response.statusCode == 201) {}
}

ShowDialog({
  BuildContext context,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('تم شكرا لك'),
        actions: <Widget>[
          FlatButton(
            child: Text("ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

Widget card({isClick, Order order}) {
  return Container(
    width: order.isClick ? 150 : 120,
    height: order.isClick ? 170 : 140,
    margin: EdgeInsets.all(order.isClick ? 0 : 10),
    child: Card(
      color: order.isClick ? Colors.blue : Colors.white,
      child: Column(
        children: <Widget>[
          Icon(
            Icons.directions_car,
            size: order.isClick ? 100 : 70,
            color: order.isClick ? Colors.white : Colors.blue,
          ),
          Text(
            '${order.ar_name == null ? '' : order.ar_name}',
            style: TextStyle(
              color: order.isClick ? Colors.white : Colors.blue,
            ),
          ),
        ],
      ),
    ),
  );
}

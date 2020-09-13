import 'dart:async';
import 'package:flutter/material.dart';
import 'package:soqya/models/global.dart';
import 'package:soqya/models/order.dart';

//import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';

Order _Order = Order('', '', '', '', '');
bool _is = false;

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  bool _Loading = true;
  List<Order> Orders = List();
  List postions = List();
  bool isClick = false;

  getData() async {
    if (connected) {
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
      _Loading = false;
      _Order = Orders[0];
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget card({isClick, Order order, context}) {
    return Container(
        margin: EdgeInsets.all(order.isClick ? 0 : 5),
        width: order.isClick ? 170 : 150,
        height: order.isClick ? 170 : 150,
        decoration: BoxDecoration(
          color: order.isClick ? Colors.teal[50] : Colors.white,
          border:
              order.isClick ? null : Border.all(color: Colors.blue, width: .5),
          borderRadius: BorderRadius.circular(170),
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/lorry.png',
              height: 90,
            ),
            Text(
              '${order.ar_name == null ? '' : order.ar_name}',
              style: TextStyle(
                color: order.isClick ? Color(0xff003d7f) : Color(0xff003d7f),
                fontFamily: 'Mj_Dinar_Two_Light',
              ),
            ),
            Text(
              '${order.price == null ? '' : order.price}',
              style: TextStyle(
                color: order.isClick ? Color(0xff003d7f) : Color(0xff003d7f),
                fontFamily: '',
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2fa4e0),
        title: Text(
          "اضافة طلبية",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'GE-Dinar_One_Medium'),
        ),
      ),
      body: Center(
        child: _is
            ? _Loading
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 100),
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height / 4.2,
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
                              child: card(
                                  context: context,
                                  order: Orders[index],
                                  isClick: isClick),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffefefef),
                        ),
                        alignment: Alignment(0, 0),
                        child: Text(
                          '${_Order.ar_name == null ? '' : _Order.ar_name}',
                          style: TextStyle(
                            fontFamily: 'GE-Dinar_One_Medium',
                            color: Color(0xff2fa4e0),
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 18,
                          left: MediaQuery.of(context).size.width / 18,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.teal[50],
                        ),
                        height: MediaQuery.of(context).size.height - 550,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'السعر',
                                  style: TextStyle(
                                    fontFamily: 'Mj_Dinar_Two_Light',
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  '${_Order.price == null ? '' : _Order.price}',
                                  style:
                                      TextStyle(fontFamily: '', fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'الضريبة',
                                  style: TextStyle(
                                      fontFamily: 'Mj_Dinar_Two_Light',
                                      fontSize: 20),
                                ),
                                Text(
                                  '${_Order.tax == null ? '' : _Order.tax}',
                                  style:
                                      TextStyle(fontFamily: '', fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'الاجمالى',
                                  style: TextStyle(
                                      fontFamily: 'Mj_Dinar_Two_Light',
                                      fontSize: 20),
                                ),
                                Text(
                                  '${_Order.total == null ? '' : _Order.total}',
                                  style:
                                      TextStyle(fontFamily: '', fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          progress(context: context, isLoading: true);
                          setOrder(context);
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(
                              right: 80,
                              left: 80,
                              top: MediaQuery.of(context).size.height / 15,
                              bottom: 50),
                          decoration: BoxDecoration(
                              color: Color(0xff2fa4e0),
                              borderRadius: BorderRadius.circular(50)),
                          alignment: Alignment(0, 0),
                          child: Text(
                            "تاكيد",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'GE-Dinar_One_Medium',
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
            : InkWell(
                onTap: () {
                  getData();
                  if (this.mounted) {
                    setState(() {});
                  }
                },
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.wifi_lock,
                      color: Color(0xff2fa4e0),
                      size: 100,
                    ),
                    Text('لا يوجد اتصال بالانترنت')
                  ],
                )),
              ),
      ),
    );
  }

  setOrder(context) async {
    if (connected) {
      var statusCode = await setNewOreder(order: _Order, quantity: 1);
      progress(context: context, isLoading: false);
      if (statusCode == 201) {
        Navigator.pushReplacementNamed(context, '/MyOrder');
      }
    } else {
      setState(() {});
    }
  }
}

Future<int> setNewOreder({Order order, int quantity}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = preferences.getString('token');
  Map<String, String> body = {
    'title': order.ar_name == null ? '' : order.ar_name,
    'quantity': '$quantity',
    'size_id': '${order.id}',
  };

  http.Response response =
      await http.post('$domain/api/orders', body: body, headers: {
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  });
  debugPrint('${response.statusCode}');
  if (response.statusCode == 201) {
    return response.statusCode;
  }
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

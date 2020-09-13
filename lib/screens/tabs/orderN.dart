import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soqya/models/global.dart';
import 'dart:convert';
import 'package:soqya/models/user_orders.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soqya/screens/detailsOrder.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

bool _is = false;

class OrderN extends StatefulWidget {
  @override
  _OrderNState createState() => _OrderNState();
}

class _OrderNState extends State<OrderN> {
  bool _Loading = true;

  _ListView() {
    return ListView.builder(
      itemCount: userOrders == null ? 0 : userOrders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
            onTap: () {
              debugPrint('${userOrders[index].station_id}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsOrder(
                    userOrders: userOrders[index],
                  ),
                ),
              ).then((value) {
                if (value == true) {
                  getData();
                }
              });
            },
            child: Container(
                margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                padding: EdgeInsets.all(10),
                //  height: MediaQuery.of(context).size.height / 6.5,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff2fa4e0)),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                ),
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${userOrders[index].mySize.size_ar_name}',
                            style: TextStyle(
                              color: Color(0xff2fa4e0),
                              fontSize: 20,
                              fontFamily: 'GE-Dinar_One_Medium',
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${userOrders[index].order_id}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff287c28),
                                  fontFamily: 'GE_Dinar_One_Light',
                                ),
                              ),
                            ),
                            Text(
                              'رقم الطلب',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff287c28),
                                fontFamily: 'GE_Dinar_One_Light',
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              userOrders[index].paymentType,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'GE_Dinar_One_Light',
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${userOrders[index].status == 'N' ? 'جديد' : userOrders[index].status == 'I' ? 'قيد التنفيذ' : userOrders[index].status == 'V' ? 'تم الالغاء' : userOrders[index].status == 'F' ? 'تم التوصيل' : ''}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontFamily: 'GE_Dinar_One_Light',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${userOrders[index].created_at.substring(0, 10)}',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'GE_Dinar_One_Light',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  List<UserOrders> userOrders = List();

  getNewOrders() async {
    if (connected) {
      _Loading = true;
      if (this.mounted) {
        setState(() {});
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String user_id = preferences.getString('user_id');

      http.Response response =
          await http.post('$domain/api/orders/read_by_user_id.php', body: {
        "user_id": user_id,
      });
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        userOrders.clear();
        var data = json.decode(response.body);
        var orders = data['orders'];
        for (var i = 0; i < orders.length; i++) {
          UserOrders order = UserOrders.formJson(orders[i]);
          if (order.status == 'N' || order.status == 'I') {
            userOrders.insert(0, order);
          }
        }
        _Loading = false;
        if (this.mounted) {
          setState(() {});
        }
      }
    } else {
      setState(() {});
    }
  }

  getData() async {
    if (connected) {
      if (this.mounted) {
        setState(() {
          getNewOrders();
          _is = true;
        });
      }
    } else {
      if (this.mounted) {
        setState(() {
          _is = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return connected
        ? _Loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : userOrders.isEmpty
                ? Center(
                    child: Text('فارغ'),
                  )
                : LiquidPullToRefresh(
                    color: Color(0xff2fa4e0),
                    backgroundColor: Theme.of(context).accentColor,
                    onRefresh: () async {
                      await getData();
                    }, // refresh callback
                    child: _ListView(), // scroll view
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
          );
  }
}

showDialossg({context, title, content}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: title,
          content: content,
        );
      });
}

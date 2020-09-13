import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soqya/api/coupons.dart';
import 'package:soqya/models/coupon_model.dart';
import 'package:soqya/models/global.dart';
import 'package:soqya/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soqya/models/orders.dart';
import 'package:soqya/models/prices.dart';
import 'package:soqya/models/size.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:soqya/models/tws_stations.dart';
import 'package:soqya/providers/user_provider.dart';
import 'package:soqya/screens/common.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  List<TwsStations> twsStations = List();
  bool isLoadingPrices = true;
  bool _isLoading = true;
  List<Prices> _prices = List();
  bool errorName = false;
  bool errorAddress = false;
  bool showDiscount = false;
  String errorA = '';
  String _total = '';
  FocusNode focusNodeA = FocusNode();
  Orders orders = Orders();
  var addController = TextEditingController();
  Future<List<TwsStations>> getAllTwsStations() async {
    twsStations = List();

    http.Response response = await http.post(
        "$domain/api/tws_stations/read.php",
        body: {"tws_stations": "tws_stations"});
    var res = json.decode(response.body);
    List data = res['tws_stations'];
    print(response.body);
    for (var json in data) {
      TwsStations _rwsStations = TwsStations();
      _rwsStations.station_id = json['station_id'];
      _rwsStations.station_code = json['station_code'];
      _rwsStations.station_en_name = json['station_en_name'];
      _rwsStations.station_ar_name = json['station_ar_name'];
      _rwsStations.organization_id = json['organization_id'];
      _rwsStations.branch_id = json['branch_id'];
      _rwsStations.country_id = json['country_id'];
      _rwsStations.state_id = json['state_id'];
      _rwsStations.city_id = json['city_id'];
      _rwsStations.area_id = json['area_id'];
      _rwsStations.en_address = json['en_address'];
      _rwsStations.ar_address = json['ar_address'];
      _rwsStations.tel_no = json['tel_no'];
      _rwsStations.fax_no = json['fax_no'];
      _rwsStations.active_ind = json['active_ind'];
      _rwsStations.created_date = json['created_date'];
      _rwsStations.created_by = json['created_by'];
      _rwsStations.modified_date = json['modified_date'];
      _rwsStations.modified_by = json['modified_by'];
      _rwsStations.station_Unq_Code = json['station_Unq_Code'];
      twsStations.add(_rwsStations);
    }
    if (twsStations.isNotEmpty) {
      orders.twsStations = twsStations[0];

      getPrices(twsStations[0].station_id);
    }
    _isLoading = false;
    setState(() {});
  }

  getPrices(station_id) async {
    if (this.mounted) {
      isLoadingPrices = true;
      _prices.clear();
      orders.prices = Prices();
      setState(() {});
    }
    try {} catch (e) {}
    http.Response response = await http.post(
        '$domain/api/prices/read_by_station_id.php',
        body: {"station_id": station_id});
    if (response.statusCode == 200) {
      print(response.body);
      var jsonOrders = await json.decode(response.body);
      List data = jsonOrders['prices'];
      for (var i = 0; i < data.length; i++) {
        Prices prices = Prices();
        prices.price_id = data[i]['price_id'];
        prices.station_id = data[i]['station_id'];
        prices.size_id = data[i]['size_id'];
        prices.price = data[i]['price'];
        prices.tax = data[i]['tax'];
        prices.total = data[i]['total'];
        prices.size = MySize(
          size_id: data[i]['size_data']['size_id'],
          size_code: data[i]['size_data']['size_code'],
          size_ar_name: data[i]['size_data']['size_ar_name'],
          size_en_name: data[i]['size_data']['size_en_name'],
        );
        if (i == 0) {
          prices.isClick = true;
        }
        _prices.add(prices);
      }
      if (_prices.isNotEmpty) {
        orders.prices = _prices[0];
        _total = orders.prices.total;
        print(orders.prices.price);
        print("-------------------------");
      }
    }
    isLoadingPrices = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  var payment_radio_group = 1;
  @override
  void initState() {
    super.initState();
    getAllTwsStations();
    //getData();
  }

  Widget card({Prices prices, context}) {
    return Container(
        margin: EdgeInsets.all(prices.isClick ? 0 : 5),
        width: prices.isClick ? 170 : 150,
        height: prices.isClick ? 170 : 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: prices.isClick ? Colors.teal[50] : Colors.white,
          border:
              prices.isClick ? null : Border.all(color: Colors.blue, width: .5),
          //borderRadius: BorderRadius.circular(170),
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/lorry.png',
              height: 90,
            ),
            Text(
              '${prices.size.size_ar_name == null ? '' : prices.size.size_ar_name}',
              style: TextStyle(
                color: prices.isClick ? Color(0xff003d7f) : Color(0xff003d7f),
                fontFamily: '',
              ),
            ),
            Text(
              '${prices.price == null ? '' : prices.price}',
              style: TextStyle(
                color: prices.isClick ? Color(0xff003d7f) : Color(0xff003d7f),
                fontFamily: '',
              ),
            ),
          ],
        ));
  }

  var noteController = TextEditingController();
  var couponController = TextEditingController();
  var orderKey = GlobalKey<ScaffoldState>();
  CouponModel couponModel;
  double totalAfterDiscount = 0;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: orderKey,
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
        child: connected
            ? _isLoading
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 100),
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("اختار المحطة"),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButton<TwsStations>(
                          isExpanded: true,
                          value: orders.twsStations,
                          items: twsStations.map((TwsStations value) {
                            return new DropdownMenuItem<TwsStations>(
                              value: value,
                              child: new Text("${value.station_ar_name}"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            orders.twsStations = value;
                            orders.quantity = 1;
                            getPrices(orders.twsStations.station_id);
                            print(orders.twsStations.station_id);
                            if (couponModel != null) {
                              calulateDiscount();
                            }
                          },
                        ),
                      ),
                      isLoadingPrices
                          ? Container(
                              padding: EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height / 4.2,
                              child: myCircularProgressIndicator())
                          : _prices.isEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: 10),
                                  height:
                                      MediaQuery.of(context).size.height / 4.2,
                                  child: Text("فارغ"))
                              : Container(
                                  padding: EdgeInsets.only(top: 10),
                                  height:
                                      MediaQuery.of(context).size.height / 4.2,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        _prices == null ? 0 : _prices.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            orders.quantity = 1;
                                            orders.prices = _prices[index];

                                            _total = orders.prices.total;
                                            if (_prices[index].isClick) {
                                            } else {
                                              for (int i = 0;
                                                  i < _prices.length;
                                                  i++) {
                                                _prices[i].isClick = false;
                                                if (index == i) {
                                                  _prices[i].isClick = true;
                                                }
                                              }
                                            }
                                          });
                                          if (couponModel != null) {
                                            calulateDiscount();
                                          }
                                        },
                                        child: card(
                                          context: context,
                                          prices: _prices[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                      /*       Container(
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
                      ),*/
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'عدد الناقلات',
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              orders.quantity++;
                              _total = (double.parse(orders.prices.total) *
                                      orders.quantity)
                                  .toStringAsFixed(2);
                              if (couponModel != null) {
                                calulateDiscount();
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: 40,
                              height: 25,
                              alignment: Alignment.center,
                              child: Text(
                                '+',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 25,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: textColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              // shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${orders.quantity}',
                              style: TextStyle(
                                fontFamily: "arlrdbd",
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (orders.quantity != 1) {
                                orders.quantity--;
                                _total = (double.parse(orders.prices.total) *
                                        orders.quantity)
                                    .toStringAsFixed(2);
                                if (couponModel != null) {
                                  calulateDiscount();
                                }
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: 40,
                              height: 25,
                              alignment: Alignment.center,
                              child: Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'طريقة الدفع',
                            style: TextStyle(
                              fontFamily: 'Mj_Dinar_Two_Light',
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'كاش',
                                style: TextStyle(
                                  fontFamily: 'Mj_Dinar_Two_Light',
                                  fontSize: 15,
                                ),
                              ),
                              Radio(
                                  value: 1,
                                  activeColor: Colors.pink,
                                  groupValue: payment_radio_group,
                                  onChanged: (v) {
                                    setState(() {
                                      payment_radio_group = v;
                                    });
                                  })
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'شبكة',
                                style: TextStyle(
                                  fontFamily: 'Mj_Dinar_Two_Light',
                                  fontSize: 15,
                                ),
                              ),
                              Radio(
                                  value: 2,
                                  activeColor: Colors.pink,
                                  groupValue: payment_radio_group,
                                  onChanged: (v) {
                                    setState(() {
                                      payment_radio_group = v;
                                    });
                                  })
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8)),
                                child: TextField(
                                  controller: couponController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          fontFamily: Common.fontName),
                                      labelText: 'كود الخصم'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              height: 48,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                color: Colors.green[600],
                                textColor: Colors.white,
                                onPressed: () {
                                  if (couponController.text.isNotEmpty) {
                                    String coupon = couponController.text;
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (ctx) => AlertDialog(
                                              content: Row(
                                                children: [
                                                  CircularProgressIndicator(),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text('جاري استرداد الكوبون')
                                                ],
                                              ),
                                            ));
                                    checkCoupon(coupon).then((value) {
                                      if (value == null) {
                                        orderKey.currentState
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          'هذا الكوبون غير متاح',
                                          style: TextStyle(
                                              fontFamily: Common.fontName),
                                        )));
                                      } else {
                                        couponModel = value;
                                        calulateDiscount();
                                        orderKey.currentState
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          'تم استرداد الكوبون بنجاح',
                                          style: TextStyle(
                                              fontFamily: Common.fontName),
                                        )));
                                        print(value.name);
                                      }
                                    }).catchError((e) {
                                      print('ErroCoupon:$e');
                                    }).whenComplete(
                                        () => Navigator.pop(context));
                                  }
                                },
                                child: Text(
                                  'استرداد',
                                  style: TextStyle(fontFamily: Common.fontName),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'الأسم',
                                  style: TextStyle(
                                    fontFamily: 'Mj_Dinar_Two_Light',
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      userProvider.userModel.name ?? '',
                                      style: TextStyle(
                                          fontFamily: '', fontSize: 20),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'رقم التليفون',
                                  style: TextStyle(
                                    fontFamily: 'Mj_Dinar_Two_Light',
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      userProvider.userModel.phone ?? '',
                                      style: TextStyle(
                                          fontFamily: '', fontSize: 20),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'رقم الهوية',
                                  style: TextStyle(
                                    fontFamily: 'Mj_Dinar_Two_Light',
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      userProvider.userModel.national_id ?? '',
                                      style: TextStyle(
                                          fontFamily: '', fontSize: 20),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider(),
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
                                Row(
                                  children: [
                                    Text(
                                      'x1',
                                      style: TextStyle(
                                        fontFamily: '',
                                        color: textColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${orders.prices.price == null ? '' : orders.prices.price}',
                                      style: TextStyle(
                                          fontFamily: '', fontSize: 20),
                                    ),
                                  ],
                                )
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
                                Row(
                                  children: [
                                    Text(
                                      'x1',
                                      style: TextStyle(
                                          fontFamily: '', color: textColor),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${orders.prices.tax == null ? '' : orders.prices.tax}',
                                      style: TextStyle(
                                          fontFamily: '', fontSize: 20),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'عدد الناقلات',
                                  style: TextStyle(
                                      fontFamily: 'Mj_Dinar_Two_Light',
                                      fontSize: 20),
                                ),
                                Text(
                                  '${orders.quantity}',
                                  style:
                                      TextStyle(fontFamily: '', fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'نوع الناقلة',
                                  style: TextStyle(
                                      fontFamily: 'Mj_Dinar_Two_Light',
                                      fontSize: 20),
                                ),
                                Text(
                                  (orders.prices.size == null)
                                      ? ''
                                      : orders.prices.size.size_ar_name,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  (showDiscount) ? 'التكلفة' : 'الاجمالى',
                                  style: TextStyle(
                                      fontFamily: 'Mj_Dinar_Two_Light',
                                      fontSize: 20),
                                ),
                                Text(
                                  '${_total == null ? '' : _total}',
                                  style:
                                      TextStyle(fontFamily: '', fontSize: 20),
                                ),
                              ],
                            ),
                            (!showDiscount)
                                ? Container()
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'نسبة الخصم',
                                            style: TextStyle(
                                                fontFamily:
                                                    'Mj_Dinar_Two_Light',
                                                fontSize: 20),
                                          ),
                                          Text(
                                            '${couponModel.value}',
                                            style: TextStyle(
                                                fontFamily: '', fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'الاجمالى',
                                            style: TextStyle(
                                                fontFamily:
                                                    'Mj_Dinar_Two_Light',
                                                fontSize: 20),
                                          ),
                                          Text(
                                            '$totalAfterDiscount',
                                            style: TextStyle(
                                                fontFamily: '', fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: addController,
                          focusNode: focusNodeA,
                          minLines: 4,
                          maxLines: 6,
                          maxLength: 200,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            errorText: errorAddress ? errorA : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            prefixIcon: Icon(Icons.details),
                            labelText: 'تفاصيل العنوان',
                          ),
                          onChanged: (input) {
                            orders.address = input;
                          },
                          onSubmitted: (input) {},
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: noteController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelText: 'إضافة ملاحظة',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setOrder(context);
                        },
                        child: Container(
                          height: 45,
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
            : InkWell(
                onTap: () {
                  //    getData();
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

  calulateDiscount() {
    double t = _total != null ? double.parse(_total) : 0;
    print('Total:$t');
    double percent = t * (int.parse(couponModel.value)) / 100;
    totalAfterDiscount = t - percent;
    totalAfterDiscount = double.parse(totalAfterDiscount.toStringAsFixed(2));
    showDiscount = true;
    orders.total_discount = totalAfterDiscount.toString();
    orders.coupon_id = couponModel.id;
    setState(() {});
  }

  setOrder(context) async {
    if (connected) {
     print('AddressValue:${addController.text.trim().length}');
      if (addController.text.trim().length!=0) {
        print('Trye');
        orders.paymentType = payment_radio_group;
        orders.note = noteController.text;
        progress(context: context, isLoading: true);
        bool result = await orders.setOrder();
        progress(context: context, isLoading: false);
        if (result) {
          Navigator.pushReplacementNamed(context, '/MyOrder');
        }
      } else {
        print('False');
       
          errorAddress = true;
          errorA = "مطلوب تفاصيل العنوان";
          setState(() {});
        
      }
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

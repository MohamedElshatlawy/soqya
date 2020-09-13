import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soqya/models/global.dart';
import 'package:soqya/models/user_orders.dart';
import 'package:soqya/providers/user_provider.dart';
import 'package:soqya/screens/common.dart';

class DetailsOrder extends StatefulWidget {
  UserOrders userOrders;
  bool rejected;

  DetailsOrder({this.userOrders, this.rejected});

  @override
  _DetailsOrderState createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  @override
  void initState() {
    super.initState();
    // print('Test:${widget.userOrders.twsStations.city_id}');
  }

  @override
  Widget build(BuildContext context) {
    var userProv = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2fa4e0),
        title: Text(
          widget.userOrders.mySize.size_ar_name,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'GE-Dinar_One_Medium'),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 200,
                child: Image.asset('assets/lorry.png'),
              ),
              /*Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),*/
              Container(
                margin: EdgeInsets.only(right: 45, left: 45, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'حالة الطلب',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontFamily: 'GE_Dinar_One_Light',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            widget.userOrders.status == 'N'
                                ? 'جديد'
                                : widget.userOrders.status == 'I'
                                    ? 'قيد التنفيذ'
                                    : widget.userOrders.status == 'V'
                                        ? 'تم الالغاء'
                                        : widget.userOrders.status == 'F'
                                            ? 'تم التوصيل'
                                            : '',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'GE_Dinar_One_Light',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'طريقة الدفع',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontFamily: 'GE_Dinar_One_Light',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            widget.userOrders.paymentType,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'GE_Dinar_One_Light',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('السعر',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontFamily: 'GE_Dinar_One_Light',
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text('${widget.userOrders.price}',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'GE_Dinar_One_Light',
                              )),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('الضريبة',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontFamily: 'GE_Dinar_One_Light',
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text('${widget.userOrders.tax}',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'GE_Dinar_One_Light',
                                fontSize: 15,
                              )),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('عدد النقلات',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'GE_Dinar_One_Light',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text('${widget.userOrders.quantity}',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'GE_Dinar_One_Light',
                                fontSize: 15,
                              )),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('السعر الاجمالى',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: 'GE_Dinar_One_Light',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text('${widget.userOrders.total}',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'GE_Dinar_One_Light',
                                fontSize: 15,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(right: 45, left: 45, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('اسم المحطة',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontFamily: 'GE_Dinar_One_Light',
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.userOrders.twsStations.station_ar_name,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontFamily: 'GE_Dinar_One_Light',
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(right: 45, left: 45, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('نوع الناقلة',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontFamily: 'GE_Dinar_One_Light',
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.userOrders.mySize.size_ar_name,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontFamily: 'GE_Dinar_One_Light',
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(
                height: 15,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(right: 45, left: 45, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'الأسم',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontFamily: 'GE_Dinar_One_Light',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            userProv.userModel.name,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'GE_Dinar_One_Light',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'رقم التليفون',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontFamily: 'GE_Dinar_One_Light',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Text(
                            userProv.userModel.phone,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'GE_Dinar_One_Light',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 45, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رقم الهوية',
                      style: TextStyle(
                          fontFamily: Common.fontName,
                          color: Colors.blue,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        userProv.userModel.national_id,
                        style: TextStyle(fontFamily: Common.fontName),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 45, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عنوان الطلب',
                      style: TextStyle(
                          fontFamily: Common.fontName,
                          color: Colors.blue,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        widget.userOrders.address_desc,
                        style: TextStyle(fontFamily: Common.fontName),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 20, 45, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ملاحظات',
                      style: TextStyle(
                          fontFamily: Common.fontName,
                          color: Colors.blue,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        (widget.userOrders.note.isEmpty)
                            ? "لايوجد"
                            : widget.userOrders.note,
                        style: TextStyle(fontFamily: Common.fontName),
                      ),
                    )
                  ],
                ),
              ),
              // (widget.rejected == true)
              //     ? Padding(
              //         padding: const EdgeInsets.fromLTRB(45, 20, 45, 20),
              //         child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               'سبب الإلغاء',
              //               style: TextStyle(
              //                   fontFamily: Common.fontName,
              //                   color: Colors.blue,
              //                   fontSize: 16),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             ),
              //             Flexible(
              //               child: Text(
              //                 widget.userOrders.cancel_reason,
              //                 style: TextStyle(fontFamily: Common.fontName),
              //               ),
              //             )
              //           ],
              //         ),
              //       )
              //     : Container(),
              (widget.userOrders.status == 'V')
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 45, 10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'سبب الإلغاء',
                                style: TextStyle(
                                    fontFamily: Common.fontName,
                                    color: Colors.red[800],
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: Text(
                                  (widget.userOrders.cancel_reason.isEmpty)
                                      ? "لايوجد"
                                      : widget.userOrders.cancel_reason,
                                  style: TextStyle(fontFamily: Common.fontName),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : Container(),
              widget.userOrders.status == 'N'
                  ? _cancelOrder(
                      context: context, userOrders: widget.userOrders)
                  : Container(
                      height: 1,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

_cancelOrder({context, UserOrders userOrders}) {
  var rController = TextEditingController();
  return InkWell(
    onTap: () async {
      showDialog(
        context: context,
        builder: (ctx) => Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            content: TextField(
              controller: rController,
              maxLines: 3,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  labelText: 'سبب الإلغاء',
                  labelStyle: TextStyle(
                    fontFamily: Common.fontName,
                  )),
            ),
            actions: [
              RaisedButton(
                onPressed: () async {
                  if (rController.text.trim().length!=0) {
                    progress(context: context, isLoading: true);
                    var statusCode = await changeStatusOrder(
                        userOrders: userOrders, rNote: rController.text);
                    progress(context: context, isLoading: false);
                    Navigator.pop(context);
                    //Navigator.pop(context);
                    if (statusCode == 200) {
                      print("${statusCode}");
                      Navigator.pop(context, true);
                    }
                  }
                },
                textColor: Colors.white,
                color: Colors.green[600],
                child: Text(
                  'تأكيد',
                  style: TextStyle(fontFamily: Common.fontName),
                ),
              )
            ],
          ),
        ),
      );
    },
    child: Container(
      height: 50,
      margin: EdgeInsets.only(
          right: 50,
          left: 50,
          top: MediaQuery.of(context).size.height / 15,
          bottom: 20),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(12.5)),
      alignment: Alignment(0, 0),
      child: Text(
        "الغاء",
        style: TextStyle(
          fontFamily: 'GE-Dinar_One_Medium',
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    ),
  );
}

Future<int> changeStatusOrder({UserOrders userOrders, String rNote}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var token = preferences.getString('token');
  http.Response response = await http.put(
    '$domain/api/orders/update_stats.php?order_id=${userOrders.order_id}&&station_Unq_Code=${userOrders.station_Unq_Code}&&status=V&&reason=$rNote',
  );
  if (response.statusCode == 200) {
    return response.statusCode;
  }
}

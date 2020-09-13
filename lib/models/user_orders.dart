import 'package:flutter/cupertino.dart';
import 'package:soqya/models/size.dart';
import 'package:soqya/models/tws_stations.dart';

class UserOrders {
  String order_id;

  String price;

  String user_id;

  String station_id;

  String size_id;

  String station_Unq_Code;

  String tax;

  String total;

  String status;

  String area_id;

  String address_desc;

  String quantity;

  String created_at;
  String note;
  String cancel_reason;

  String paymentType;

  TwsStations twsStations;

  MySize mySize;

  UserOrders();

  UserOrders.addOrder(
      {this.order_id,
      this.price,
      this.user_id,
      this.station_id,
      this.size_id,
      this.station_Unq_Code,
      this.tax,
      this.total,
      this.status,
      this.area_id,
      this.address_desc,
      this.quantity,
      this.created_at,
      this.twsStations,
      this.mySize,
      this.note,
      this.paymentType,
      this.cancel_reason});

  factory UserOrders.formJson(Map<String, dynamic> map) {
    var v = TwsStations.FromJson(map['station_info']);
    print('dd:${v.station_id}');
    return UserOrders.addOrder(
      order_id: map['order_id'],
      price: map['price'],
      user_id: map['user_id'],
      station_id: map['station_id'],
      size_id: map['size_id'],
      station_Unq_Code: map['station_Unq_Code'],
      tax: map['tax'],
      total: map['total'],
      status: map['status'],
      area_id: map['area_id'],
      address_desc: map['address_desc'],
      quantity: map['quantity'],
      note: map['note'] ?? "",
      cancel_reason: map['cancel_reason'] ?? "",
      paymentType: map['paymentType'] ?? "",
      created_at: map['created_at'],
      twsStations: TwsStations.FromJson(map['station_info']),
      mySize: MySize.formJson(map['size_data']),
    );
  }
}

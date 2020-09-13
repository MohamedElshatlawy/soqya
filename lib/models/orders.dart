import 'package:shared_preferences/shared_preferences.dart';
import 'package:soqya/models/prices.dart';
import 'package:soqya/models/size.dart';
import 'package:soqya/models/tws_stations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'global.dart';

class Orders {
  TwsStations twsStations;
  MySize mySize;
  Prices prices;
  String address;
  int quantity;
  int paymentType;
  String note;
  String coupon_id;
  String total_discount;

  Orders(
      {this.twsStations,
      this.mySize,
      this.note,
      this.prices,
      this.address = '',
      this.quantity = 1});

  Future<bool> setOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user_id = preferences.getString('user_id');
    Map<String, String> body = {
      'user_id': user_id,
      'station_id': this.twsStations.station_id,
      'station_Unq_Code': this.twsStations.station_Unq_Code,
      'size_id': prices.size.size_id,
      'price': prices.price,
      'tax': prices.tax,
      'total': prices.total,
      'area_id': this.twsStations.area_id,
      'address_desc': address,
      'quantity': this.quantity.toString(),
      'paymentType': (paymentType == 1) ? 'كاش' : 'شبكة',
      'note': note,
      'coupon_id': coupon_id ?? "لا يوجد",
      'total_discount': total_discount ?? prices.total
    };

    http.Response response = await http.post(
      '$domain/api/orders/create.php',
      body: body,
    );
    print('${response.body}');
    var data = json.decode(response.body);
    if (!data['error']) {
      return true;
    }
    return false;
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soqya/models/coupon_model.dart';
import 'package:soqya/models/global.dart';

Future<CouponModel> checkCoupon(String coupon) async {
  var response =
      await http.get("$domain/api/coupon/checkCoupon.php?coupon=$coupon");

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    if (json['coupon'] == null) {
      return null;
    }
    return CouponModel.fromJson(json['coupon']);
  }
  print(response.body);
}

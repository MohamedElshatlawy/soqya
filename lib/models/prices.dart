import 'package:soqya/models/size.dart';

class Prices {
  bool isClick = false;
  String price_id;
  String station_id;
  String size_id;
  String price;
  String tax;
  String total;
  MySize size;

  Prices({
    this.price_id,
    this.station_id,
    this.size_id,
    this.price,
    this.tax,
    this.total,
    this.size,
  });

  factory Prices.formJson(map) {
    return Prices(
        price_id :map['price_id'],
        station_id :map['station_id'],
        size_id :map['size_id'],
        price :map['price'],
        tax :map['tax'],
        total :map['total'],
        size :MySize.formJson(map['size_data']));
  }
}

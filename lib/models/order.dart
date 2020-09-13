class Order {
  bool _isClick =false;
  int _id;
  String _code;
  String _ar_name;
  String _en_name;
  var _price;
  var _tax;
  var _total;
  String _created_at;
  String _updated_at;
  Order(this._ar_name, this._en_name ,this._price,this._tax ,this._total,);
  Order.fromJson(Map<String, dynamic> map) {
    _id = map['id'];
    _code = map['code'];
    _ar_name = map['ar_name'];
    _en_name = map['en_name'];
    _price = map['price'];
    _tax = map['tax'];
    _total = map['total'];
    _created_at = map['created_at'];
    _updated_at = map['updated_at'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['id'] = _id;
    map['code'] = _code;
    map['ar_name'] = _ar_name;
    map['en_name'] = _en_name;
    map['price'] = _price;
    map['tax'] = _tax;
    map['total'] = _total;
    map['created_at'] = _created_at;
    map['updated_at'] = _updated_at;
    return map;
  }

  int get id => _id;
  String get code => _code;
  String get ar_name => _ar_name;
  String get en_name => _en_name;
  dynamic get price => _price;
  dynamic get tax => _tax;
  dynamic get total => _total;
  String get created_at => _created_at;
  String get updated_at => _updated_at;

  bool get isClick => _isClick;
  
  void setClick(bool isClick) {
    _isClick = isClick;
  }
}

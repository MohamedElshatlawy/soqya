class CouponModel {
  String id;
  String name;
  String value;

  CouponModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.value = json['value'];
  }
}

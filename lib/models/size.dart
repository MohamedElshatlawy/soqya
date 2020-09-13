class MySize {
  String size_id;
  String size_code;
  String size_ar_name;
  String size_en_name;

  MySize({
    this.size_id,
    this.size_code,
    this.size_ar_name,
    this.size_en_name,
  });

  factory MySize.formJson(Map<String, dynamic> map) {
    return MySize(
    size_id: map['size_id'],
    size_code: map['size_code'],
    size_ar_name: map['size_ar_name'],
    size_en_name: map['size_en_name'],
    );
  }
}

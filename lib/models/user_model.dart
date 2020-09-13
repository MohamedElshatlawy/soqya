class UserModel {
  String id;
  String name;
  String mail;
  String phone;
  String national_id;
  UserModel.fromJson(Map<String, dynamic> json) {
    this.id = json['user_id'];
    this.name = json['first_name'] + json['last_name'];
    this.mail = json['email'];
    this.phone = json['phone_number'];
    this.national_id = json['national_id'];
  }
}

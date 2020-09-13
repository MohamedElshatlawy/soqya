class ComplainModel {
  String id;
  String complain;
  String user_id;
  ComplainModel({this.complain});
  ComplainModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.complain = json['complain'];
    this.user_id = json['user_id'];
  }
}

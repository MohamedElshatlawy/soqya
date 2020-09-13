import 'dart:convert';

import 'package:http/http.dart';
import 'package:soqya/models/complainModel.dart';
import 'package:soqya/models/global.dart';

Future<List<ComplainModel>> getComps(String id) async {
  List<ComplainModel> coms = [];
  var body = {"user_id": id};
  var response = await post("$domain/api/complain/getComp.php", body: body);

  var json = jsonDecode(response.body);
  print(json);

  List d = json['items'];
  d.forEach((element) {
    coms.add(ComplainModel.fromJson(element));
  });
  return coms;
}

import 'package:http/http.dart';
import 'package:soqya/models/global.dart';

Future updateUser(
    {String name,
    String mail,
    String phone,
    String national_id,
    String user_id}) async {
  print("Name:$name");
  var params = {
    'first_name': name.split(" ")[0],
    'last_name': name.split(" ")[1],
    'email': mail,
    'national_id': national_id,
    'phone_number': phone,
    "user_id": user_id
  };
  print(params);
  var response = await post("$domain/api/user/update.php", body: params);
  print(response.body);
  return response.body;
}

Future createComplain({String user_id, String complain}) async {
  var params = {"user_id": user_id, "complain": complain};
  var response = await post("$domain/api/complain/create.php", body: params);
  print(response.body);
  return response.body;
}

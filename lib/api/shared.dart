import 'package:shared_preferences/shared_preferences.dart';

saveUserShared(String mail, String password) async {
  var sh = await SharedPreferences.getInstance();
  sh.setString('mail', mail);
  sh.setString("password", password);
}

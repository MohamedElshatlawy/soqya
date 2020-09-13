import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:soqya/api/fcm.dart';
import 'package:soqya/models/global.dart';
import 'package:soqya/models/user_model.dart';
import 'package:soqya/providers/user_provider.dart';
import 'package:soqya/screens/homScreen.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  SharedPreferences prefs;
  bool isLogin = false;
  StreamSubscription<ConnectivityResult> subscription;
  getUserInfoSplash(String em, String pss) async {
    print(em + " " + pss);
    await post('$domain/api/user/login.php', body: {
      "emailORPhoneNumber": em,
      "password": pss,
    }).then((value) async {
      var success = json.decode(value.body);
      print(value.body);
      if (!success['error']) {
        print('Success:');
        var prov = Provider.of<UserProvider>(context, listen: false);

        prov.setUser(UserModel.fromJson(success['user_info']));
        prov.setUser(UserModel.fromJson(success['user_info']));
        SharedPreferences.getInstance().then((value) {
          value.setString("user_id", prov.userModel.id);
        });

        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (BuildContext context) => Login(),
          ),
        );
      }
    }).catchError((e) {
      print('ERRORgETUser:$e');
    });
  }

  _sharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLogin') == null ? false : prefs.getBool('isLogin')) {
      String mail = prefs.getString("email");
      String pw = prefs.getString("password");
      print('trueddd');
      await getUserInfoSplash(mail, pw);
    } else {
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
          builder: (BuildContext context) => Login(),
        ),
      );
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  checkConnect() async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        connected = false;
      } else if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        connected = true;
      }
      print(connected);
    });
  }

  @override
  void initState() {
    super.initState();
    handleFCM();
    checkConnect();
    Timer(Duration(seconds: 2), () async {
      //  _sharedPreferences();
//
      var sh = await SharedPreferences.getInstance();
      if (sh.getString('mail') == null) {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (BuildContext context) => Login(),
          ),
        );
      } else {
        getUserInfoSplash(sh.getString('mail'), sh.getString('password'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Scaffold(
          body: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/water.jpeg'),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 6),
                  child: Image.asset("assets/logo.png"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

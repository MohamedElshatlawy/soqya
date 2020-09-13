import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:soqya/api/shared.dart';
import 'package:soqya/models/global.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soqya/models/user_model.dart';
import 'package:soqya/providers/user_provider.dart';

import 'verifyAccout.dart';

var iconPassword = Icons.visibility_off;
var isVisibility = true;
var email = TextEditingController();
var password = TextEditingController();
var token = '';
bool login = false;

bool isError = false;
var error = '';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode focusNodePassword = FocusNode();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String smsCode;
  String verificationId;

  _setLogin({email, password}) async {
    if (connected) {
      progress(context: context, isLoading: true);

      http.Response response =
          await http.post('$domain/api/user/login.php', body: {
        "emailORPhoneNumber": email,
        "password": password,
      });
      print('${response.statusCode}');
      print('${response.body}');
      var success = json.decode(response.body);
      progress(context: context, isLoading: false);
      if (!success['error']) {
        resetData();
        var prov = Provider.of<UserProvider>(context, listen: false);

        prov.setUser(UserModel.fromJson(success['user_info']));
        SharedPreferences.getInstance().then((value) {
          value.setString("user_id", prov.userModel.id);
        });

        saveUserShared(email, password);
        // await _incrementLogin(success['user_info']['user_id']);
        Navigator.of(context).pushReplacementNamed('/HomeScreen');
      } else {
        isError = true;
        switch (success['message']) {
          case "password":
            error = 'كلمة المرور غير صحيحة';
            break;
          case "emailORPhoneNumber":
            error = 'هذه البيانات غير مسجله من قبل';
            break;
          default:
        }
      }

      if (this.mounted) {
        setState(() {});
      }
    } else {
      notConnected(context: context);
    }
  }

  Future<void> verifyPhone({token, code, phoneNumber}) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      progress(context: context, isLoading: false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyAccount(
            token: token,
            code: code,
            phoneNumber: phoneNumber,
            verificationId: verificationId,
          ),
        ),
      );
    };
    final PhoneVerificationCompleted verificationSuccess =
        (AuthCredential user) async {
      progress(context: context, isLoading: false);
      print('verificationSuccess');
      print('verified');
      bool _verify = await verify(token: token, code: code);
      if (_verify) {
        _setLogin(email: email.text, password: password.text);
      }
      setState(() {});
    };
    final PhoneVerificationFailed verificationFailed =
        (var exception) {
      progress(context: context, isLoading: false);
      print('verificationFailed');
      print('${exception.message}');
    };
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 1),
        verificationCompleted: verificationSuccess,
        verificationFailed: verificationFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve);
  }

  Future<bool> verify({code, token}) async {
    http.Response response =
        await http.post('$domain/api/verify', body: <String, dynamic>{
      "code": '$code',
    }, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    var data = json.decode(response.body);
    print(data);
    if (data['status'] == null ? false : data['status']) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> virfy({BuildContext context}) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'الرجاء التواصل مع خدمة العملة لتفعيل الحساب \n شكرا لستخدامكم التطبيق سقيا الدينة',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'تم',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  resetData() {
    email.clear();
    password.clear();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.jpg'), fit: BoxFit.fill)),
      child: ListView(
        //  mainAxisAlignment: MainAxisAlignment.center,
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 10,
                right: MediaQuery.of(context).size.width / 10,
                top: MediaQuery.of(context).size.height / 5,
              ),
              //  height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              alignment: Alignment.bottomCenter,
              child: Column(
                children: <Widget>[
                  //Text('safddfasf',style: TextStyle(color: Colors.blue,fontSize: 50,fontFamily: 'lemonada_bold'),),
                  Container(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/profile-icon.png')),
                  Container(
                    child: TextField(
                        onTap: () {
                          isError = false;
                        },
                        onSubmitted: (input) {
                          FocusScope.of(context)
                              .requestFocus(focusNodePassword);
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: InputDecoration(
                          labelStyle:
                              TextStyle(fontFamily: 'GE_Dinar_One_Light'),
                          errorText: isError ? error : null,
                          labelText: 'البريد الالكترونى او رقم الجوال',
                          icon: Icon(Icons.email),
                        )),
                    //  margin: EdgeInsets.fromLTRB(50, 0, 50, 20),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: TextField(
                            onChanged: (v) {
                              isError = false;
                            },
                            focusNode: focusNodePassword,
                            keyboardType: TextInputType.text,
                            controller: password,
                            onSubmitted: (input) {
                              _setLogin(
                                  email: email.text, password: password.text);
                            },
                            decoration: InputDecoration(
                                errorText: isError ? error : null,
                                labelText: 'كلمة المرور',
                                labelStyle:
                                    TextStyle(fontFamily: 'GE_Dinar_One_Light'),
                                icon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isVisibility) {
                                          iconPassword = Icons.visibility;
                                          isVisibility = false;
                                        } else {
                                          iconPassword = Icons.visibility_off;
                                          isVisibility = true;
                                        }
                                      });
                                    },
                                    child: Icon(iconPassword))),
                            obscureText: isVisibility,
                          ),
                          margin: EdgeInsets.fromLTRB(0, 10, 0,
                              MediaQuery.of(context).size.height / 50),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/ForgetPassword');
                                },
                                child: Container(
                                  child: Text(
                                    'لا اتذكرة كلمة المرور؟',
                                    style: TextStyle(
                                        color: Color(0xff003d7f),
                                        fontSize: 12,
                                        fontFamily: 'GE_Dinar_One_Light'),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/Register');
                                },
                                child: Container(
                                  width: 130,
                                  //  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  alignment: Alignment.center,
                                  decoration:
                                      BoxDecoration(color: Color(0xff2fa4e0)),
                                  child: Text(
                                    'تسجيل حساب جديد',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'GE_Dinar_One_Light'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _setLogin(email: email.text, password: password.text);
            },
            child: Container(
                // padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 10,
                ),
                height: MediaQuery.of(context).size.height / 9,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25)),
                ),
                alignment: Alignment.center,
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                      color: Color(0xff003d7f),
                      fontSize: 30,
                      fontFamily: 'GE_Dinar_One_Light'),
                )),
          ),
        ],
      ),
      alignment: Alignment.center,
    ));
  }
}

String validateName(String value) {
  if (value.length < 3)
    return 'Name must be more than 2 charater';
  else
    return null;
}

String validateMobile(String value) {
  if (value.length != 10)
    return 'Mobile Number must be of 10 digit';
  else
    return null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

_incrementLogin(user_id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email.text);
  await prefs.setString('password', password.text);
  await prefs.setString('user_id', user_id);
  await prefs.setBool('isLogin', true);
}

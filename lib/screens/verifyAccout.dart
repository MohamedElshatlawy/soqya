import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import 'package:progress_indicator_button/progress_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:soqya/models/global.dart';

import 'login.dart';

class VerifyAccount extends StatefulWidget {
  var token;
  var code;
  var phoneNumber;
  String verificationId;

  VerifyAccount({
    this.token,
    this.code,
    this.phoneNumber,
    this.verificationId,
  });

  @override
  _VerifyAccountState createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  var code = ' ';
  var errorCode = ' ';
  var isErrorCode = false;

  var smsCode = ' ';

  signIn() async {
    await FirebaseAuth.instance.signOut();
    AuthCredential AuthCredentialauthCredential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: smsCode);
    await FirebaseAuth.instance
        .signInWithCredential(AuthCredentialauthCredential)
        .then((var user) async {
      // user.user.delete();
      print('login');
      await verify();
      /* FirebaseUser user =   await FirebaseAuth.instance.currentUser();
         user.delete();*/
      progress(context: context, isLoading: false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
//      Navigator.pushReplacement(
//        context,
//        MaterialPageRoute(
//          builder: (context) => Login(),
//        ),
//      );
    }).catchError((e) {
      progress(context: context, isLoading: false);
      errorCode = 'كود التفعيل غير صحيح';
      isErrorCode = true;
      setState(() {});
      print(e);
    });
  }

  Future<bool> verify() async {
    http.Response response =
        await http.post('$domain/api/verify', body: <String, dynamic>{
      "code": '${widget.code}',
    }, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer ${widget.token}",
    });
    var data = json.decode(response.body);
    print(data);
    return true;
    /* if (data['status'] == null ? false : data['status']) {
      return true;
    } else {
      errorCode = 'كود التفعيل صحيح';
      isErrorCode = true;
      return false;
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.fill)),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'تم ارسال كود التفعيل على رقم الجوال',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: TextField(
                    onTap: () {
                      if (this.mounted) {
                        setState(() {
                          isErrorCode = false;
                        });
                      }
                    },
                    onChanged: (value) {
                      code = value;
                      this.smsCode = value;
                      print(code);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorText: isErrorCode ? errorCode : null,
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'كود التفعيل',
                      icon: Icon(Icons.mobile_screen_share),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    progress(context: context, isLoading: true);
                    isErrorCode = false;
                    if (code.isNotEmpty && code.length > 3) {
                      var user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        errorCode = 'كود التفعيل غير صحيح';
                        isErrorCode = true;
                        print('login');
                        setState(() {});
                      } else {
                        //  Navigator.of(context).pop();
                        signIn();
                      }
                    } else if (code.isEmpty) {
                      progress(context: context, isLoading: false);
                      errorCode = 'كود التفعيل مطلوب';
                      isErrorCode = true;
                    } else if (code.length < 4) {
                      progress(context: context, isLoading: false);
                      errorCode = 'كود التفعيل غير صحيح';
                      isErrorCode = true;
                    } else {
                      progress(context: context, isLoading: false);
                      errorCode = 'كود التفعيل صحيح';
                      isErrorCode = true;
                    }
                    setState(() {});
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(
                        right: 50,
                        left: 50,
                        top: MediaQuery.of(context).size.height / 15,
                        bottom: 20),
                    decoration: BoxDecoration(
                        color: Color(0xff003d7f),
                        borderRadius: BorderRadius.circular(12.5)),
                    alignment: Alignment(0, 0),
                    child: Text(
                      'تاكيد رقم الجوال',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ) // _Stepper(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

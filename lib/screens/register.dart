import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:soqya/models/global.dart';
import 'login.dart';
import 'verifyAccout.dart';

var iconPassword = Icons.visibility_off;
var isVisibility = true;
var isVisibility2 = true;
var _countriesName = [];
var _countriesId = [];

var countryName = '';
int countryId = 5;
var _stateName = [];
var _stateId = [];

var stateName = '';
int stateId = 4;

bool isState = false;
var _cityName = [];
var _cityId = [];

var cityName = '';
int cityId = 4;
bool isCity = false;

var _areaName = [];
var _areaId = [];

var areaName = '';
int areaId = 4;

bool isArea = false;

var _firstName = TextEditingController();
var _lastName = TextEditingController();
var _email = TextEditingController();
var _password = TextEditingController();
var confirm_pass = TextEditingController();
var _nationalId = TextEditingController();
var _phoneNumber = TextEditingController();
FocusNode focusNodeLastName = FocusNode();
FocusNode focusNodeEmail = FocusNode();
FocusNode focusNodePassword = FocusNode();
FocusNode focusNodePassword2 = FocusNode();
FocusNode focusNodeNationalId = FocusNode();
FocusNode focusNodePhoneNumber = FocusNode();

var _detailsAddress = TextEditingController();

bool isVisible = false;

bool isErrorFirstName = false;
String errorFirstName;
bool isErrorLastName = false;
String errorLastName;
bool isErrorEmail = false;
String errorEmail;
bool isErrorPassword = false;
String errorPassword;
bool isErrorPassword2 = false;
String errorPassword2;

bool isErrorNationalId = false;
String errorNationalId;
bool isErrorPhoneNumber = false;
String errorPhoneNumber;
bool isErrorDetailsAddress = false;
String errorDetailsAddress;
bool isErrorAddress = false;
String errorAddress;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

var regKey = GlobalKey<ScaffoldState>();

class _RegisterState extends State<Register> {
  Future<int> Rigsiter() async {
    progress(context: context, isLoading: true);
    if (connected) {
      http.Response response = await http.post(
        '$domain/api/user/register.php',
        body: <String, dynamic>{
          "first_name": _firstName.text,
          "last_name": _lastName.text,
          "email": _email.text,
          "password": _password.text,
          "phone_number": _phoneNumber.text, //phoneNo,
          "national_id": _nationalId.text,
        },
      );
      print('${response.statusCode}');
      print('${response.body}');
      var data = json.decode(response.body);
      progress(context: context, isLoading: false);
      if (!data['error']) {
        _firstName.clear();
        _lastName.clear();
        _email.clear();
        _password.clear();
        _nationalId.clear();
        _phoneNumber.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
        return response.statusCode;
      } else {
        progress(context: context, isLoading: false);
        print(data['error']);
        switch (data['message']) {
          case "email":
            isErrorEmail = true;
            errorEmail = "البريد الاكتروني مستخدم من قبل";
            break;
          case "national_id":
            isErrorNationalId = true;
            errorNationalId = "رقم الهوية مستخدم من قبل";
            break;
          case "phone":
            isErrorPhoneNumber = true;
            errorPhoneNumber = 'رقم الجوال مستخدم من قبل';
            break;
        }
        if (this.mounted) {
          setState(() {});
        }
      }
    } else {
      notConnected(context: context);
    }
  }

  sendSMS({code, number}) async {
    http.Response response =
        await http.post('https://mobily.ws/api/msgSendWK.php', body: {
      "mobile": "966555555555",
      "password": "123456",
      "numbers": "966444444444,966533333333",
      "sender": "NEW SMS",
      "msg": " (لغاي",
      "lang": "3",
      "msgKey":
          "(1),*, محمد,@,( 2022/30/12,*,)2),*,أحمد,@,(1(***2022/30/10,*,)2 ",
      "msgId": "0",
      "applicationType": "68",
      "timeSend": "13:30:00",
      "dateSend": "12/30/2022",
      "deleteKey": "758423"
    });
    var data = await json.decode(response.body);
    print(data);
    if (data == '1') {}
  }

  getCountry() async {
    http.Response response = await http.get('$domain/api/countries');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      _countriesName.clear();
      _countriesId.clear();
      List<dynamic> country = await json.decode(response.body);
      for (var i = 0; i < country.length; i++) {
        _countriesName.insert(0, country[i]['ar_name']);
        _countriesId.insert(0, country[i]['id']);
        print(country[i]['id']);
        countryName = country[i]['ar_name'];
        countryId = country[i]['id'];
      }
      int index = _countriesName.indexOf(countryName);

      if (index != 0 && index != -1) {
        int id = country[index]['id'];
        await getStates(id);
      }
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  getStates(id) async {
    isState = true;
    http.Response response = await http.get('$domain/api/states?country=$id"');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      _stateName.clear();
      _stateId.clear();
      List<dynamic> state = await json.decode(response.body);
      for (var i = 0; i < state.length; i++) {
        _stateName.insert(0, state[i]['ar_name']);
        _stateId.insert(0, state[i]['id']);
        stateName = state[i]['ar_name'];
        stateId = state[i]['id'];
        print(state[i]['ar_name']);
      }
      if (_stateName.isEmpty) {
        isState = false;
      }
      int index = _stateName.indexOf(stateName);
      if (index != 0 && index != -1) {
        int id = state[index]['id'];
        await getCity(id);
      }

      if (this.mounted) {
        setState(() {});
      }
    }
  }

  getCity(id) async {
    isCity = true;
    http.Response response = await http.get('$domain/api/cities?state=$id');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      _cityName.clear();
      _cityId.clear();
      List<dynamic> city = await json.decode(response.body);
      for (var i = 0; i < city.length; i++) {
        _cityName.insert(0, city[i]['ar_name']);
        _cityId.insert(0, city[i]['id']);
        cityName = city[i]['ar_name'];
        cityId = city[i]['id'];
        print(city[i]['ar_name']);
      }
      if (_cityName.isEmpty) {
        isCity = false;
      }
      int index = _cityName.indexOf(cityName);
      if (index != 0 && index != -1) {
        int id = city[index]['id'];
        await getArea(id);
      }

      if (this.mounted) {
        setState(() {});
      }
    }
  }

  getArea(id) async {
    isArea = true;
    http.Response response = await http.get('$domain/api/areas?city=$id');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      _areaName.clear();
      _areaId.clear();
      List<dynamic> area = await json.decode(response.body);
      for (var i = 0; i < area.length; i++) {
        _areaName.insert(0, (area[i]['ar_name']));
        _areaId.insert(0, (area[i]['id']));
        areaName = area[i]['ar_name'];
        areaId = area[i]['id'];
        print(area[i]['ar_name']);
      }

      if (_areaName.isEmpty) {
        isArea = false;
        isVisible = false;
      }
      if (this.mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //getCountry();
    isState = true;
    getStates(5);
    //verifyPhone();
  }

  resetData() {
    isCity = false;
    isArea = false;
    isVisible = false;

    _firstName.clear();
    _lastName.clear();
    _email.clear();
    _password.clear();
    _nationalId.clear();
    _phoneNumber.clear();
    _detailsAddress.clear();
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: regKey,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.fill)),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15,
                    top: MediaQuery.of(context).size.height / 17,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onTap: () {
                          if (this.mounted) {
                            setState(() {
                              isErrorFirstName = false;
                            });
                          }
                        },
                        controller: _firstName,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          errorText: isErrorFirstName ? errorFirstName : null,
                          icon: Icon(Icons.perm_identity),
                          labelText: 'الاسم الاول',
                          labelStyle:
                              TextStyle(fontFamily: 'GE_Dinar_One_Light'),
                        ),
                        onSubmitted: (input) {
                          FocusScope.of(context)
                              .requestFocus(focusNodeLastName);
                        },
                      ),
                      TextField(
                        focusNode: focusNodeLastName,
                        onTap: () {
                          if (this.mounted) {
                            setState(() {
                              isErrorLastName = false;
                            });
                          }
                        },
                        onSubmitted: (input) {
                          FocusScope.of(context).requestFocus(focusNodeEmail);
                        },
                        controller: _lastName,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          errorText: isErrorLastName ? errorLastName : null,
                          icon: Icon(Icons.perm_identity),
                          labelText: 'الاسم العائلة',
                          labelStyle:
                              TextStyle(fontFamily: 'GE_Dinar_One_Light'),
                        ),
                      ),
                      TextField(
                        onTap: () {
                          if (this.mounted) {
                            setState(() {
                              isErrorEmail = false;
                            });
                          }
                        },
                        onSubmitted: (input) {
                          FocusScope.of(context)
                              .requestFocus(focusNodePassword);
                        },
                        controller: _email,
                        focusNode: focusNodeEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorText: isErrorEmail ? errorEmail : null,
                          icon: Icon(Icons.email),
                          labelText: 'البريد الالكترونى',
                          labelStyle:
                              TextStyle(fontFamily: 'GE_Dinar_One_Light'),
                        ),
                      ),
                      TextField(
                        onTap: () {
                          if (this.mounted) {
                            setState(() {
                              isErrorPassword = false;
                            });
                          }
                        },
                        controller: _password,
                        focusNode: focusNodePassword,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            errorText: isErrorPassword ? errorPassword : null,
                            labelText: 'كلمة المرور',
                            labelStyle:
                                TextStyle(fontFamily: 'GE_Dinar_One_Light'),
                            icon: InkWell(
                                onTap: () {
                                  if (this.mounted) {
                                    setState(() {
                                      if (isVisibility) {
                                        iconPassword = Icons.visibility;
                                        isVisibility = false;
                                      } else {
                                        iconPassword = Icons.visibility_off;
                                        isVisibility = true;
                                      }
                                    });
                                  }
                                },
                                child: Icon(iconPassword))),
                        obscureText: isVisibility,
                        onSubmitted: (input) {
                          FocusScope.of(context)
                              .requestFocus(focusNodeNationalId);
                        },
                      ),
                      TextField(
                        onTap: () {
                          if (this.mounted) {
                            setState(() {
                              isErrorPassword = false;
                            });
                          }
                        },
                        controller: confirm_pass,
                        focusNode: focusNodePassword2,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            //   errorText: isErrorPassword2 ? errorPassword2 : null,
                            labelText: 'تأكيد كلمة المرور',
                            labelStyle:
                                TextStyle(fontFamily: 'GE_Dinar_One_Light'),
                            icon: InkWell(
                                onTap: () {
                                  if (this.mounted) {
                                    setState(() {
                                      if (isVisibility2) {
                                        iconPassword = Icons.visibility;
                                        isVisibility2 = false;
                                      } else {
                                        iconPassword = Icons.visibility_off;
                                        isVisibility2 = true;
                                      }
                                    });
                                  }
                                },
                                child: Icon(iconPassword))),
                        obscureText: isVisibility2,
                        onSubmitted: (input) {
                          FocusScope.of(context)
                              .requestFocus(focusNodeNationalId);
                        },
                      ),
                      TextField(
                        onTap: () {
                          if (this.mounted) {
                            setState(() {
                              isErrorNationalId = false;
                            });
                          }
                        },
                        onSubmitted: (input) {
                          FocusScope.of(context)
                              .requestFocus(focusNodePhoneNumber);
                        },
                        focusNode: focusNodeNationalId,
                        controller: _nationalId,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          errorText: isErrorNationalId ? errorNationalId : null,
                          icon: Icon(Icons.recent_actors),
                          labelText: 'رقم الهوية',
                          labelStyle:
                              TextStyle(fontFamily: 'GE_Dinar_One_Light'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              onTap: () {
                                if (this.mounted) {
                                  setState(() {
                                    isErrorPhoneNumber = false;
                                  });
                                }
                              },
                              focusNode: focusNodePhoneNumber,
                              controller: _phoneNumber,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                errorText: isErrorPhoneNumber
                                    ? errorPhoneNumber
                                    : null,
                                icon: Icon(Icons.phone_iphone),
                                labelText: 'رقم الجوال',
                                labelStyle:
                                    TextStyle(fontFamily: 'GE_Dinar_One_Light'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                if (_password.text != confirm_pass.text) {
                  print('UserPassword:${password.text}');
                  print('User2Password:${confirm_pass.text}');
                  regKey.currentState.showSnackBar(SnackBar(
                      content: Text(
                    'كلمة المرور غير متطابقة',
                    textAlign: TextAlign.center,
                  )));
                } else {
                  progress(context: context, isLoading: true);
                  Rigsiter();
                }
              },
              child: Container(
                  // padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 15,
                  ),
                  height: MediaQuery.of(context).size.height / 9,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.5),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'تسجيل ',
                    style: TextStyle(
                        color: Color(0xff003d7f),
                        fontSize: 30,
                        fontFamily: 'GE_Dinar_One_Light'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

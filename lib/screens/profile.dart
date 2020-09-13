import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:soqya/api/user_profile.dart';
import 'package:soqya/models/global.dart';
import 'package:soqya/models/user_orders.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = true;
  var userInfo;
  var name = '';
  var email = '';
  var phone_number = '';
  var national_id = '';
  var userID;

  getInfo() async {
    if (connected) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      http.Response response = await http.get(
        '$domain/api/user/read_b_user_id.php?user_id=${preferences.get('user_id')}',
      );
      print('${response.statusCode}');
      if (response.statusCode == 200) {
        userInfo = await json.decode(response.body);
        name = '${userInfo['first_name']} ${userInfo['last_name']}';
        nameController.text = name;

        email = '${userInfo['email']}';
        mailController.text = email;

        phone_number = '${userInfo['phone_number']}';
        phoneController.text = phone_number;

        national_id = '${userInfo['national_id']}';
        idController.text = national_id;

        userID = userInfo['user_id'];

        print(userInfo);
      }
      isLoading = false;
      if (this.mounted) {
        setState(() {});
      }
    } else {
      notConnected(context: context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myFocusNode = FocusNode();
    getInfo();
  }

  bool isEdit = false;
  var nameController = TextEditingController();
  var mailController = TextEditingController();
  var phoneController = TextEditingController();
  var idController = TextEditingController();
  FocusNode myFocusNode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.fill,
          ),
          Center(
            child: isLoading
                ? myCircularProgressIndicator()
                : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.teal[50],
                              ),
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 10,
                                  bottom:
                                      MediaQuery.of(context).size.height / 5),
                              // height: MediaQuery.of(context).size.height - 250,
                              width: MediaQuery.of(context).size.width - 50,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(top: 30),
                                      width: 125,
                                      height: 125,
                                      child: Image.asset(
                                          'assets/profile-icon.png')),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                      child: FocusScope(
                                    child: Focus(
                                      child: TextField(
                                        focusNode: myFocusNode,
                                        autofocus: isEdit,
                                        //   readOnly: !isEdit,
                                        readOnly: (isEdit) ? false : true,
                                        controller: nameController,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xff003d7f),
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  )

                                      // Text(name,
                                      //     style: TextStyle(
                                      //         color: Color(0xff003d7f),
                                      //         fontSize: 25,
                                      //         fontWeight: FontWeight.bold)),
                                      ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              25,
                                          right: 20,
                                          left: 20),
                                      child: ListTile(
                                        title: TextField(
                                          enabled: isEdit,
                                          style: TextStyle(
                                            fontFamily: 'GE_Dinar_One_Light',
                                            color: Color(0xff003d7f),
                                          ),
                                          controller: mailController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                        leading: Icon(
                                          Icons.email,
                                          color: Color(0xff003d7f),
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              25,
                                          right: 20,
                                          left: 20),
                                      child: ListTile(
                                        title: TextField(
                                          enabled: isEdit,
                                          style: TextStyle(
                                            fontFamily: 'GE_Dinar_One_Light',
                                            color: Color(0xff003d7f),
                                          ),
                                          controller: phoneController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                        leading: Icon(
                                          Icons.phone_android,
                                          color: Color(0xff003d7f),
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              25,
                                          right: 20,
                                          left: 20),
                                      child: ListTile(
                                        title: TextField(
                                          enabled: false,
                                          style: TextStyle(
                                            fontFamily: 'GE_Dinar_One_Light',
                                            color: Color(0xff003d7f),
                                          ),
                                          controller: idController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                        leading: Icon(
                                          Icons.language,
                                          color: Color(0xff003d7f),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: double.infinity,
                                    child: RaisedButton(
                                      onPressed: () async {
                                        if (isEdit) {
                                          //updateInfol

                                          showDialog(
                                              context: context,
                                              builder: (ctx) => Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                      title: Row(
                                                        children: <Widget>[
                                                          CircularProgressIndicator(),
                                                          SizedBox(
                                                            width: 25,
                                                          ),
                                                          Text(
                                                            'جاري نحديث البيانات',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'GE_Dinar_One_Light',
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ));

                                          await updateUser(
                                                  name: nameController.text,
                                                  mail: mailController.text,
                                                  user_id: userID,
                                                  national_id:
                                                      idController.text,
                                                  phone: phoneController.text)
                                              .then((value) {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop('dialog');
                                            var json = jsonDecode(value);
                                            if (json['error'] == false) {
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "تم تحديث البيانات بنجاح",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "حدث خطأ في تحديث البيانات حاول مرة اخرى !",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          }).catchError((e) {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop('dialog');
                                            Fluttertoast.showToast(
                                                msg:
                                                    "حدث خطأ في تحديث البيانات حاول مرة اخرى !",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }).whenComplete(() {
                                            setState(() {
                                              isEdit = false;
                                            });
                                          });
                                        } else {
                                          isEdit = !isEdit;
                                          setState(() {});
                                          if (isEdit == true) {
                                            print('foaa');
                                            // FocusScope.of(context).previousFocus();

                                            myFocusNode.requestFocus();
                                          }
                                          setState(() {});
                                        }
                                      },
                                      color: Color(0xff003d7f),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      textColor: Colors.teal[50],
                                      child: Text(
                                        (isEdit == false) ? 'تعديل' : 'حفظ',
                                        style: TextStyle(
                                            // color: Color(0xff003d7f),
                                            fontFamily: 'GE_Dinar_One_Light',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

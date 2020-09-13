import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:soqya/api/com_api.dart';
import 'package:soqya/api/user_profile.dart';
import 'package:soqya/models/complainModel.dart';
import 'package:soqya/providers/user_provider.dart';
import 'package:soqya/screens/common.dart';

class Complain extends StatefulWidget {
  @override
  _ComplainState createState() => _ComplainState();
}

class _ComplainState extends State<Complain> {
  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var complainController = TextEditingController();

  var comKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    getComps(userProvider.userModel.id).then((value) {
      print('Success:');
      data.clear();
      data.addAll(value);
      data = data.reversed.toList();
    }).catchError((e) {
      print('ErrorGetData:$e');
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: comKey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            'ارسال شكاوى',
            style: TextStyle(
              color: Color(0xffefefef),
              fontFamily: 'GE-Dinar_One_Medium',
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(color: Colors.grey)),
              //   child: TextField(
              //     controller: nameController,
              //     decoration: InputDecoration(
              //         contentPadding: EdgeInsets.all(10),
              //         border: InputBorder.none,
              //         labelText: 'الأسم بالكامل',
              //         labelStyle: TextStyle(fontFamily: Common.fontName)),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(color: Colors.grey)),
              //   child: TextField(
              //     controller: phoneController,
              //     keyboardType: TextInputType.phone,
              //     decoration: InputDecoration(
              //         contentPadding: EdgeInsets.all(10),
              //         border: InputBorder.none,
              //         labelText: 'رقم التليفون',
              //         labelStyle: TextStyle(fontFamily: Common.fontName)),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child: TextField(
                  controller: complainController,
                  textAlignVertical: TextAlignVertical.top,
                  textAlign: TextAlign.start,
                  maxLines: 6,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      alignLabelWithHint: true,
                      border: InputBorder.none,
                      labelText: 'مضمون الشكوى',
                      labelStyle: TextStyle(fontFamily: Common.fontName)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  width: double.infinity,
                  height: 48,
                  child: RaisedButton(
                    onPressed: () {
                      if (!validateInputs()) {
                        comKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                            'من فضلك ادخل البيانات المطلوبة',
                            style: TextStyle(fontFamily: Common.fontName),
                          ),
                        ));
                        return;
                      }

                      sendComplain(userProvider.userModel.id);
                    },
                    textColor: Colors.white,
                    child: Text(
                      'ارسال',
                      style: TextStyle(fontFamily: Common.fontName),
                    ),
                    color: Colors.blue,
                  )),
              Expanded(
                  child: Center(
                child: (loading == true)
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (ctx, index) => Card(
                              child: ListTile(
                                title: Text(data[index].complain),
                              ),
                            )),
              ))
            ],
          ),
        ),
      ),
    );
  }

  bool loading = true;
  List<ComplainModel> data = [];
  validateInputs() {
    print(complainController.text);
    if (complainController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Future sendComplain(String id) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
              content: Row(
                textDirection: TextDirection.rtl,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'جاري ارسال الشكوى',
                    style: TextStyle(fontFamily: Common.fontName),
                  ),
                ],
              ),
            ));

    await createComplain(complain: complainController.text, user_id: id)
        .then((value) {
      Navigator.pop(context);
      var json = jsonDecode(value);
      if (json['error'] == false) {
        data.add(ComplainModel(complain: complainController.text));
        data = data.reversed.toList();
        setState(() {});
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "تم ارسال الشكوى بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        print("Error2:$value");
        Fluttertoast.showToast(
            msg: "حدث خطأ حاول مرة اخرى",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((e) {
      print("Error:$e");
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "حدث خطأ حاول مرة اخرى",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}

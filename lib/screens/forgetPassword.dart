import 'package:flutter/material.dart';
import 'package:soqya/models/forgotPssword.dart';
import 'package:soqya/models/global.dart';
import '../logo.dart';
import 'verifyCode.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordScreeState createState() => _ForgotPasswordScreeState();
}

class _ForgotPasswordScreeState extends State<ForgotPassword> {
  RecoveryPassword recoveryPassword =
  RecoveryPassword(email: '', phone_number: '');
  var height;
  var width;
  bool obscureTextValue = true;
  int groupModelIndex = 0;
  String groupModelValue = 'Student';

  int _currVal = 1;
  String _currText = '';

  bool erroremail = false;
  bool errorphone_number = false;

  String errorE = '';
  String errorP = '';

  FocusNode focusNodeP = FocusNode();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.fill)),
        child: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20, // height / 100 * 2,
                right: 0,
                left: 0,
                child: Container(width: 200, height: 200, child: Logo()),
              ),
              Positioned(
                top: height / 100 * 35,
                right: 0,
                left: 0,
                child: Container(
                  color: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      recoveryPassword.message.isNotEmpty
                          ? Text(
                        recoveryPassword.message,
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(color: textColor, fontSize: 20),
                      )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            errorText: erroremail ? errorE : null,
                            prefixIcon: Icon(Icons.email),
                            labelText:'ادخل البريد الاكتروني',
                            labelStyle: TextStyle(
                              fontFamily: "GE_Dinar_One_Light",
                            )),
                        style: TextStyle(
                          fontFamily: "",
                        ),
                        onChanged: (input) {
                          recoveryPassword.email = input;
                        },
                        onSubmitted: (input) {},
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        style: TextStyle(
                          fontFamily: "",
                        ),
                        focusNode: focusNodeP,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            errorText: erroremail ? errorE : null,
                            prefixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  obscureTextValue = !obscureTextValue;
                                });
                              },
                              child: Icon(
                                Icons.phone_android,
                              ),
                            ),
                            labelText: 'ادخل رقم الهاتف',
                            labelStyle: TextStyle(
                              fontFamily: "GE_Dinar_One_Light",
                            )),
                        onChanged: (input) {
                          recoveryPassword.phone_number = input;
                        },
                        onSubmitted: (input) {
                          setRecovery();
                        },
                      ),
                      SizedBox(
                        height: height / 15,
                      ),
                      InkWell(
                        onTap: setRecovery,
                        child: Container(
                          width: width / 2,
                          height: height / 100 * 5,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: textColor,
                          ),
                          child: Text(
                            "Submit",
                            // 'سجل الان',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ), ),
    );
  }

  void setRecovery() async {

    setState(() {
      erroremail = false;
      errorphone_number = false;
    });
    if (recoveryPassword.email.isNotEmpty &&
        recoveryPassword.email.contains('@') &&
        recoveryPassword.phone_number.isNotEmpty) {
      progress(context: context, isLoading: true);

      bool isDone = await recoveryPassword.recoveryP();
      progress(context: context, isLoading: false);
      if (isDone) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyCode(recoveryPassword)));
      } else {}
    } else {
      if (recoveryPassword.email.isEmpty) {
        erroremail = true;
        errorE = 'email Is Required';
      } else if (!recoveryPassword.email.contains('@')) {
        erroremail = true;
        errorE = 'Make Sure This email Is Not Correct';
      }
      if (recoveryPassword.phone_number.isEmpty) {
        errorphone_number = true;
        errorP = 'Phone Number Is Required';
      }
      setState(() {});
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseAuth.instance.currentUser().then((val) {
    //   setState(() {
    //     this.uid = val.uid;
    //   });
    // }).catchError((e) {
    //   print(e);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(child: Text('Your are now logged in as $uid')),
          SizedBox(
            height: 20,
          ),
          Text('home'),
          SizedBox(
            height: 20,
          ),
          Text('home'),
        ],
      ),
    );
  }
}

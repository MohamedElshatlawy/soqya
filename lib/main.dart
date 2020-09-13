import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:soqya/providers/user_provider.dart';
import 'package:soqya/screens/aboutDeveloper.dart';
import 'package:soqya/screens/callUs.dart';
import 'package:soqya/screens/forgetPassword.dart';
import 'package:soqya/screens/verifyAccout.dart';
import 'screens/profile.dart';
import 'screens/homScreen.dart';
import 'screens/aboutUs.dart';
import 'screens/myOrder.dart';
import 'screens/newOrder.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';
import './screens/splashScreen.dart';
import 'screens/register.dart';
import 'screens/addOrder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider.value(
      value: UserProvider(),
      child: MaterialApp(
        builder: (BuildContext context, Widget child) {
          return new Directionality(
            textDirection: TextDirection.rtl,
            child: new Builder(
              builder: (BuildContext context) {
                return new MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1.0,
                  ),
                  child: child,
                );
              },
            ),
          );
        },
        theme: ThemeData(
          accentColor: Colors.yellow,
          primaryColor: Color(0xff003d7f),
        ),
        debugShowCheckedModeBanner: false,
        title: 'سقيا المدينة',
        routes: <String, WidgetBuilder>{
          '/HomeScreen': (BuildContext context) => HomeScreen(),
          '/Register': (BuildContext context) => Register(),
          '/Login': (BuildContext context) => Login(),
          '/Profile': (BuildContext context) => Profile(),
          '/AboutUs': (BuildContext context) => AboutUS(),
          '/AboutDeveloper': (BuildContext context) => AboutDeveloper(),
          '/MyOrder': (BuildContext context) => MyOrder(),
          '/NewOrder': (BuildContext context) => NewOrder(),
          '/AddOrder': (BuildContext context) => AddOrder(),
          '/ForgetPassword': (BuildContext context) => ForgotPassword(),
          '/CallUs': (BuildContext context) => CallUs(),
          '/VerifyAccount': (BuildContext context) => VerifyAccount(),
        },
        home: Splash(),
      ),
    );
  }
}

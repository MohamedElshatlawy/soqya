import 'package:firebase_messaging/firebase_messaging.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

handleFCM() async {
  var fcm = FirebaseMessaging();
  var token = await fcm.getToken();
  print('MyToken:$token');
  fcm.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      //    _showItemDialog(message);
    },
    onBackgroundMessage: myBackgroundMessageHandler,
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
      //     _navigateToItemDetail(message);
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      //  _navigateToItemDetail(message);
    },
  );
}

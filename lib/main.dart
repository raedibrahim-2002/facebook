import 'dart:io';

import 'package:facebook/display_home.dart';
import 'package:facebook/notifications.dart';
import 'package:facebook/register.dart';
import 'package:facebook/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // هنستدعي init بشكل مباشر بدون object
  await PreferenceUtils.init();
  initNotifications();
  FirebaseMessaging.instance.getToken().then((value) => (value) {
    print("FCM token $value");
  });


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      print('Message also contained a notification: ${message.notification!.title}');
      print('Message also contained a notification: ${message.notification!.body}');

      dispayNotifications(message.notification!.title!, message.notification!.body!);
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
getToken();
if(Platform.isAndroid)
{
  requestingAndroidPermission();

}
super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        // add tabBarTheme
        tabBarTheme: const TabBarTheme(
          dividerColor: Color(0xFF313131),
          indicatorColor: Color(0xFF313131),
          labelColor: Color(0xFF434343),
          labelStyle: TextStyle(color: Color(0xFF434343)), // color for text
          indicator: UnderlineTabIndicator(
            // color for indicator (underline)
            borderSide: BorderSide(color: Color(0xFF434343)),
          ),
        ),
        primaryColor:
            const Color(0xFF434343), // outdated and has no effect to TabBar
        //
      ),
      //  when we press to log Out it deletes userData so currentUser = null
      // but if we restart the app it be already have an userData

      home: FirebaseAuth.instance.currentUser == null
          ? const Login()
          : DisplayHome(),
    );
  }
  getToken()async {
    var myToken = await FirebaseMessaging.instance.getToken();
    print(myToken);
  }

}

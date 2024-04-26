import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notifi/imagep/criminalview.dart';
import 'package:notifi/imagep/imageupload.dart';
import 'package:notifi/imagep/imageview.dart';
import 'package:notifi/screens/login.dart';
import 'package:notifi/screens/signin.dart';
import 'package:notifi/validation/validate.dart';

import 'package:notifi/warn/warnpage.dart';
import 'firebase_options.dart';
import '/warn/push_notifications.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future _firebaseBackgroundMessaging(RemoteMessage message) async {
  if (message.notification != null) {
    navigatorKey.currentState!.pushNamed("/message");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    if (message.notification != null) {
      print("Background Notification Tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  PushNotifications.init();
  PushNotifications.localNotiInit();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessaging);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadData,
      );
    }
  });

  final RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }

  
  FirebaseMessaging.instance.subscribeToTopic("news_updates");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) =>  const LoginPage(),
        '/message': (context) => const WarnPage(),
        '/login': (context) => const LoginPage(),
        '/signup' :(context) => const SignUpPage(),
        '/upload' : (context) => const ImageUpload(),
         '/valid' :(context) =>  PinPage(),
         '/view' :(context) =>  ImageListScreen(),
         '/vie' :(context) =>  ImageListScree(),


      },
    );
  }
}

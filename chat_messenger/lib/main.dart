import 'package:chat_messenger/screens/001_welcome.dart';
import 'package:chat_messenger/screens/002_login.dart';
import 'package:chat_messenger/screens/003_registration.dart';
import 'package:chat_messenger/screens/004_chat_select.dart';
import 'package:chat_messenger/screens/005_chat.dart';
import 'package:chat_messenger/screens/006_userprofile.dart';
import 'package:chat_messenger/utilits/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteTable.welcome,
        routes: {
          RouteTable.welcome: ((context) => WelcomeScreen()),
          RouteTable.login: ((context) => LoginScreen()),
          RouteTable.registered: ((context) => RegisteredScreen()),
          RouteTable.selectChat: ((context) => SelectChat()),
          RouteTable.chat: ((context) => ChatScreen()),
          RouteTable.userprofile: ((context) => UserProfile()),
        });
  }
}

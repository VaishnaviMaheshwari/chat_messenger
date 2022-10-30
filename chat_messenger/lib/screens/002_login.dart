import 'package:chat_messenger/utilits/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utilits/component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final _auth = FirebaseAuth.instance;
  String _email = "";
  String _password = "";
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                      height: 100, child: Image.asset('assets/logo.png')),
                ),
              ),
              TextEntry(
                hintText: "enter email",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {
                  setState(() {
                    _email = val;
                  });
                },
              ),
              TextEntry(
                hintText: "enter password",
                icon: Icons.key,
                keyboardType: TextInputType.text,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    _password = val;
                  });
                },
              ),
              ButtonRound(
                  onPressed: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                        email: _email,
                        password: _password,
                      );
                      if (user != null) {
                        Navigator.pushNamed(context, RouteTable.selectChat);
                      }
                    } catch (err) {
                      debugPrint(err.toString());
                    }

                    // Navigator.pushNamed(context, RouteTable.selectChat);
                  },
                  title: 'Sign In',
                  color: AppColors.primaryColor),
              TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Not Registered!!",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

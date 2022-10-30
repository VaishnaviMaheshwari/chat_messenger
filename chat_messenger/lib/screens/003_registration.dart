import 'package:chat_messenger/utilits/component.dart';
import 'package:chat_messenger/utilits/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisteredScreen extends StatefulWidget {
  const RegisteredScreen({Key? key}) : super(key: key);

  @override
  State<RegisteredScreen> createState() => _RegisteredScreenState();
}

class _RegisteredScreenState extends State<RegisteredScreen> {
  String _email = "";
  String _password = "";
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
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
                onChanged: (val) {
                  setState(() {
                    _email = val;
                  });
                },
                hintText: "enter email",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
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
                  debugPrint(_email);
                  debugPrint(_password);
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    );
                    if (newUser != null) {
                      _firestore
                          .collection('chatUser')
                          .add({'email': _email, 'username': ""});
                      Navigator.pushNamed(context, RouteTable.selectChat);
                    }
                  } catch (err) {
                    debugPrint(err.toString());
                  }
                },
                title: 'Sign Up',
                color: AppColors.primaryColor,
              ),
              TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "already registered!",
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

import 'package:chat_messenger/utilits/component.dart';
import 'package:chat_messenger/utilits/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectChat extends StatefulWidget {
  const SelectChat({Key? key}) : super(key: key);

  @override
  State<SelectChat> createState() => _SelectChatState();
}

class _SelectChatState extends State<SelectChat> {
  List<String> users = [];
  int currentIndex = 0;
  final _auth = FirebaseAuth.instance;
  late User currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final _firestore = FirebaseFirestore.instance;
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        var data =
            await _firestore.collection('chatUser').orderBy('email').get();
        setState(() {
          currentUser = user;
          for (var d in data.docs) {
            users.add(d.data()['email']);
          }
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() {
                _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteTable.welcome, (route) => false);
              }),
              icon: Icon(Icons.logout))
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        elevation: 30,
        leading: SizedBox(),
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Chatjet",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (String username in users)
              ChatCard(
                username: username,
                onTap: () {
                  Navigator.pushNamed(context, RouteTable.chat,
                      arguments: {"receiver": username});
                },
              )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.primaryColor,
        onTap: (ind) {
          if (ind != currentIndex) {
            if (ind == 0) {
              Navigator.pushNamed(context, RouteTable.selectChat);
            } else if (ind == 1)
              Navigator.pushNamed(context, RouteTable.userprofile);
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
            ),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
          )
        ],
      ),
    );
  }
}

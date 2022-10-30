import 'package:chat_messenger/utilits/constants.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            CircleAvatar(backgroundImage: AssetImage('assets/oyy.jpg'))
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

import 'package:chat_messenger/utilits/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ButtonRound extends StatelessWidget {
  const ButtonRound({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.color,
    this.isIcon = false,
  }) : super(key: key);
  final onPressed;
  final title;
  final color;
  final isIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 5,
        color: color,
        child: MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: isIcon
              ? Icon(Icons.send, color: Colors.white)
              : Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1)),
          height: 60,
          minWidth: 200,
        ),
      ),
    );
  }
}

class TextEntry extends StatelessWidget {
  TextEntry(
      {Key? key,
      this.onChanged,
      this.keyboardType,
      this.obscureText = false,
      required this.hintText,
      this.icon})
      : super(key: key);
  final onChanged;
  final keyboardType;
  final obscureText;
  final String hintText;
  final icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextField(
        cursorColor: AppColors.primaryColor,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              color: AppColors.primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 2))),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({Key? key, this.onTap, this.username = ""}) : super(key: key);
  final onTap;
  final username;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, Random().nextInt(255),
                      Random().nextInt(255), Random().nextInt(255)),
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(username),
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key, this.username = "", this.isMe = false, this.message = ""})
      : super(key: key);
  final username;
  final bool isMe;
  final message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMe
          ? const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 10,
              left: 60,
            )
          : const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 60,
              left: 10,
            ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          Material(
            elevation: 2,
            color: isMe ? Colors.red : Colors.white30,
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15))
                : BorderRadius.only(topLeft: Radius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

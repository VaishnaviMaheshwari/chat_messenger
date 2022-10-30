import 'package:chat_messenger/utilits/component.dart';
import 'package:chat_messenger/utilits/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map> messageData = [
    {"username": "abc", "message": "hii", "isMe": false},
    {"username": "xyz", "message": "whatsup", "isMe": true},
    {"username": "abc", "message": "nothing much", "isMe": false}
  ];
  late String _receiver;
  final _auth = FirebaseAuth.instance;
  late User currentUser;
  String _typedText = '';

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
        setState(() {
          currentUser = user;
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    if (arg != null) {
      setState(() {
        _receiver = arg['receiver'];
      });
    }
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          elevation: 30,
          // leading: SizedBox(),
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Chatjet",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(children: [
          // Expanded(
          //   child: ListView(
          //     children: [
          //       for (var messageData in messageData)
          //         MessageBubble(
          //           isMe: messageData["isMe"],
          //           username: messageData['username'],
          //           message: messageData['message'],
          //         )
          //     ],
          //   ),
          // )
          MessageStream(
              sender: currentUser.email as String, receiver: _receiver),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextEntry(
                      hintText: "message",
                      onChanged: (val) {
                        setState(() {
                          _typedText = val;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonRound(
                        onPressed: () {
                          _firestore.collection('messages').add(
                            {
                              'text': _typedText,
                              'sender': currentUser.email,
                              'receiver': _receiver,
                              'createdAt': Timestamp.now(),
                            },
                          );
                        },
                        color: AppColors.primaryColor,
                        title: ">",
                        isIcon: true,
                      ),
                    ))
              ],
            ),
          ),
        ]));
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key, required this.sender, required this.receiver})
      : super(key: key);
  final String sender;
  final String receiver;
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    return StreamBuilder(
        stream:
            firestore.collection('messages').orderBy('createdAt').snapshots(),
        builder: ((context, snapshot) {
          // snapshot.data;
          List<Map> messageData = [];
          if (snapshot.hasData) {
            // for (var data in snapshot.data!.docs) {}
          }
          final allmessages = snapshot.data;

          return Expanded(
            child: ListView(
              children: [
                for (var messageData in messageData)
                  MessageBubble(
                    isMe: messageData["isMe"],
                    username: messageData['username'],
                    message: messageData['message'],
                  )
              ],
            ),
          );
        }));
  }
}

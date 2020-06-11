import 'package:chat/widgets/chat/messages.dart';
import 'package:chat/widgets/chat/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String logout = 'logout';

  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (msg) {
        print('App in Forground');
        print(msg);
        return;
      },
      onResume: (msg) {
        print('App in background');
        print(msg);
        return;
      },
      onLaunch: (msg) {
        print('App in Terminated');
        print(msg);
        return;
      },
    );
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHAT ME'),
        centerTitle: true,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              style: TextStyle(color: Colors.black),
              focusColor: Colors.black,
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.teal,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Messages(),
              ),
              NewMessages(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  NewMessages({Key key}) : super(key: key);

  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String _enterMessage = '';
  final _messageController = TextEditingController();
  void _sendMessage() async {
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'message': _enterMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData['username'],
      'userImage': userData['userImage'],
    });
    setState(() {
      _messageController.clear();
      _enterMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _messageController,
                autocorrect: true,
                textCapitalization: TextCapitalization.sentences,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[400],
                  hintText: 'Send a message....',
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[350], width: 0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                ),
                onChanged: (value) {
                  setState(() {
                    _enterMessage = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: _enterMessage.trim().isEmpty
                    ? Colors.grey
                    : Theme.of(context).accentColor,
                radius: 23,
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      
                      size: 28,
                    ),
                    onPressed:
                        _enterMessage.trim().isEmpty ? null : _sendMessage,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

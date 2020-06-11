import 'package:chat/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureUserData) {
        if (futureUserData.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, chatSnapshat) {
            if (chatSnapshat.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final chatDoc = chatSnapshat.data.documents;
            return ListView.builder(
              reverse: true,
              itemCount: chatDoc.length,
              itemBuilder: (context, index) => MessageBubble(
                chatDoc[index]['message'],
                chatDoc[index]['userName'],
                chatDoc[index]['userImage'],
                chatDoc[index]['userId'] == futureUserData.data.uid,
                key: ValueKey(chatDoc[index].documentID),
              ),
            );
          },
        );
      },
    );
  }
}

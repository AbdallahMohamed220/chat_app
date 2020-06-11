import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  final Key key;
  MessageBubble(this.message, this.userName,this.userImage, this.isMe, {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
                color: isMe ? Colors.grey[350] : Theme.of(context).accentColor,
              ),
              width: 150,
              child: Column(
                 crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                   Text(
                    userName,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message,
                    textAlign: isMe
                          ? TextAlign.end
                          : TextAlign.start,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                      fontSize: 15,
                      
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      Positioned(
        top: 4,
        right: isMe?140:null,
        left: isMe?null:140,
        child:CircleAvatar(
          backgroundImage: NetworkImage(userImage),
          
        )
        
      )
      ],
      overflow: Overflow.visible,
    );
  }
}

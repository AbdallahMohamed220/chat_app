import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHAT ME',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, userSnapShot) {
          if(userSnapShot.connectionState == ConnectionState.waiting){
            return SplashScreen();
          }
          if (userSnapShot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}

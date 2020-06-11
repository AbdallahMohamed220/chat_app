import 'dart:io';

import 'package:chat/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _sumitForm(
    String email,
    String username,
    String password,
    bool isLogin,
    File image,
    BuildContext ctx,
  ) async {
    AuthResult _authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref= FirebaseStorage.instance
            .ref()
            .child('users_images')
            .child(_authResult.user.uid + 'jpg');

         await ref.putFile(image).onComplete;

          final userImage= await ref.getDownloadURL();

        await Firestore.instance
            .collection('users')
            .document(_authResult.user.uid)
            .setData({
          'username': username,
          'email': email,
          'userImage':userImage,
        });
      }
    } on PlatformException catch (err) {
      String message = 'An error occurred, please check your Credential';
      if (err.message != null) {
        message = err.message;

        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ));
      }
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
      print("Error is $err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_sumitForm, _isLoading),
    );
  }
}

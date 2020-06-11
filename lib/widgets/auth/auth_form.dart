import 'dart:io';
import 'package:chat/picker/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this._submitForm,
    this._isLoading,
  );
  bool _isLoading;
  void Function(
    String email,
    String usernamr,
    String password,
    bool isLogin,
    File userFileImage,
    BuildContext ctx,
  ) _submitForm;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _showPassword = false;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File userFileImage;
  _uploadImage(File userImage) {
    userFileImage = userImage;
  }

  _submitForm() {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (userFileImage == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image .'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (_isValid) {
      _formKey.currentState.save();
      widget._submitForm(_userEmail.trim(), _userName.trim(),
          _userPassword.trim(), _isLogin, userFileImage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(_uploadImage),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      key: ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Email',
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[100], width: 0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  if (!_isLogin)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        key: ValueKey('username'),
                        autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty || value.length < 3) {
                            return 'Username must be at least 3 char';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userName = value;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Username',
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[100], width: 0.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      key: ValueKey('password'),
                      
                      keyboardType: TextInputType.text,
                      obscureText: !_showPassword,
                      validator: (value) {
                        if (value.isEmpty || value.length < 8) {
                          return 'Password must at least 8 char';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Password',
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[100], width: 0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: _showPassword
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: _submitForm,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  if (!widget._isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(
                          () {
                            _isLogin = !_isLogin;
                          },
                        );
                      },
                      child: Text(
                        _isLogin
                            ? 'Create new account'
                            : 'I already have an account',
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

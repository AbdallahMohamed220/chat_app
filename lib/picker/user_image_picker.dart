import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File userImage) uploadImage;
  UserImagePicker(this.uploadImage);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _userImage;
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );


    setState(() {
      _userImage = File(pickedFile.path);
    });
    await widget.uploadImage(_userImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 45,
          backgroundImage: _userImage == null ? null : FileImage(_userImage),
          backgroundColor: Colors.grey[350],
        ),
        FlatButton.icon(
          icon: Icon(Icons.image),
          textColor: Theme.of(context).primaryColor,
          label: Text('Add Image'),
          onPressed: _getImage,
        ),
      ],
    );
  }
}

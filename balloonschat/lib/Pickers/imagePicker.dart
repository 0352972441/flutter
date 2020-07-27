import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickers extends StatefulWidget {
  @override
  ImagePickers(this._selectedImage);
  final Function _selectedImage;
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickers> {
  File _imagePicker;
  void pickerImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagePicker = image;
    });
    widget._selectedImage(_imagePicker);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue,
          backgroundImage:
              _imagePicker == null ? null : FileImage(_imagePicker),
        ),
        if (_imagePicker == null)
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.green,
                size: 30,
              ),
              onPressed: pickerImage)
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _image;

  void _takePicture() async {
    // final _imagePicker = await ImagePicker()
    //     .getImage(source: ImageSource.gallery, maxWidth: 600);
    final _imagePicker =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    setState(() {
      _image = _imagePicker; //File(_imagePicker.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 150,
          width: 150,
          //constraints: BoxConstraints(minHeight: 70, maxHeight: 80),
          decoration:
              BoxDecoration(border: Border.all(width: 2, color: Colors.blue)),
          child: _image != null
              ? Image.file(_image)
              : Text("Take a picture now",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.add_a_photo),
              label: Text("Take Photo")),
        ),
      ],
    );
  }
}

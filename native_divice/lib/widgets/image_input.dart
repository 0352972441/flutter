import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {
  final Function _imageSelected;
  ImageInput(this._imageSelected);
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
    if (_imagePicker == null) {
      return;
    }
    final paths = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(_imagePicker.path);
    final saveImage = await _imagePicker.copy('${paths.path}/$fileName');
    widget._imageSelected(saveImage);
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

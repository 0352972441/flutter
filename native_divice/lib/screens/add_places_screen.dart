import 'package:flutter/material.dart';
import 'package:native_divice/provider/great_places.dart';
import 'package:native_divice/widgets/image_input.dart';
import 'dart:io';
import '../widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlacesScreen extends StatefulWidget {
  static const routeName = '/add-places';
  @override
  _AddPlacesScreenState createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final _titleControler = TextEditingController();
  File _imageSelected;

  void imageSelected(File imageSelected) {
    _imageSelected = imageSelected;
  }

  void addSingle() {
    if (_titleControler.text.isEmpty || _imageSelected == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addSinglePlace(_titleControler.text, _imageSelected);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Places"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Title",
                          labelStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w900)),
                      controller: _titleControler,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ImageInput(imageSelected),
                    SizedBox(
                      height: 20,
                    ),
                    LocationInput()
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            //shape:BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            textColor: Colors.black,
            onPressed: () => addSingle(),
            icon: Icon(Icons.add_photo_alternate),
            label: Text("Add"),
            color: Theme.of(context).primaryColor,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        ],
      ),
    );
  }
}

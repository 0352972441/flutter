import 'package:flutter/material.dart';
import 'package:native_divice/widgets/image_input.dart';

class AddPlacesScreen extends StatefulWidget {
  static const String routeName = '/add-places';
  @override
  _AddPlacesScreenState createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final _titleControler = TextEditingController();

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
                    ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            //shape:BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            textColor: Colors.black,
            onPressed: () {},
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

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../helpers/locationHelper.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _image;
  Location location = new Location();
  Future<void> currentLocation() async {
    print("Awaiting");
    try {
      final locaData =
          await location.getLocation(); //await Location().getLocation();
      final imageUrlMap = LocationHelper.generateLocationPreviewImage(
          latitude: locaData.latitude, longitude: locaData.longitude);
      setState(() {
        _image = imageUrlMap;
      });
      print("Vĩ độ - latitude : ${locaData.latitude}");
      print("Kinh độ - longitude ${locaData.longitude}");
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blue)),
              child: _image == null
                  ? Center(
                      child: Text("Don't have location"),
                    )
                  : Image.network(
                      _image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: currentLocation,
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  label: Text("Current location")),
              FlatButton.icon(
                  onPressed: currentLocation,
                  icon: Icon(Icons.map),
                  label: Text("Map"))
            ],
          )
        ],
      ),
    );
  }
}

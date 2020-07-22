import 'dart:io';

import 'package:flutter/foundation.dart';

class LocationPlace {
  final String lutitude;
  final String longitude;
  final String address;

  LocationPlace(
      {@required this.lutitude, @required this.longitude, this.address});
}

class Place {
  final String id;
  final String title;
  final LocationPlace location;
  final File image; // Thao tác với storange Sử dụng file để lưu trữ ảnh

  Place(
      {@required this.id,
      @required this.title,
      @required this.location,
      @required this.image});
}

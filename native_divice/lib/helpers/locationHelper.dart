const GOOGLE_API_KEY = 'AIzaSyDmN79jMNWljfPahD1lvVdh8Yrg6AkiGLg';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:T%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'env_keys.dart';
import 'package:http/http.dart' as http;

class LocationUtils {
  static String getMapPreviewImage(
      {required double latitude, required double longitude}) {
    String googleApi = EnvKeys.googleApi;
    return 'https://maps.googleapis.com/maps/api/staticmap?'
        'center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap'
        '&markers=color:red%7Clabel:P%7C$latitude,$longitude'
        '&key=$googleApi';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    String googleApi = EnvKeys.googleApi;
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApi';
    final response = await http.get(Uri.parse(url));

    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}

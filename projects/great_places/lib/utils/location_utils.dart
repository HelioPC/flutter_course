import 'env_keys.dart';

class LocationUtils {
  static String getMapPreviewImage({required double latitude, required double longitude}) {
    String googleApi = EnvKeys.googleApi;
    return 'https://maps.googleapis.com/maps/api/staticmap?'
    'center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap'
    '&markers=color:red%7Clabel:P%7C$latitude,$longitude'
    '&key=$googleApi';
  }
}
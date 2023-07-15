import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_utils.dart';
import 'package:great_places/utils/location_utils.dart';

class GreatPlaces extends ChangeNotifier {
  List<Place> _list = [];

  List<Place> get list => [..._list];

  int get count => _list.length;

  Future<void> loadPlaces() async {
    final data = await DBUtils.getData('places');

    _list = data
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            location:
                const PlaceLocation(latitude: 0, longitude: 0, address: ''),
            image: File(e['image']),
          ),
        )
        .toList();

    notifyListeners();
  }

  void addPlace(String title, File image, LatLng position) async {
    final address = await LocationUtils.getAddressFrom(position);

    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
      image: image,
    );

    _list.add(newPlace);

    DBUtils.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );

    notifyListeners();
  }
}

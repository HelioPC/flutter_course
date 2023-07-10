import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces extends ChangeNotifier {
  final List<Place> _list = [];

  List<Place> get list => [..._list];

  int get count => _list.length;

  void addPlace(String title, File image) {
    _list.add(
      Place(
        id: Random().nextDouble().toString(),
        title: title,
        location: PlaceLocation(latitude: 0, longitude: 0, address: ''),
        image: image,
      ),
    );

    notifyListeners();
  }
}

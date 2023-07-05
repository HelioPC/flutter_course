import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces extends ChangeNotifier {
  final List<Place> _list = [];

  List<Place> get list => [..._list];

  int get count => _list.length;
}

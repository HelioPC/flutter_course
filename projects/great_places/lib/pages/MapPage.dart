import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapPage extends StatefulWidget {
  final PlaceLocation location;

  const MapPage({
    super.key,
    this.location = const PlaceLocation(
      latitude: -8.814848852931075,
      longitude: 13.231915276376839,
      address: '',
    ),
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select custom location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 14,
        ),
      ),
    );
  }
}

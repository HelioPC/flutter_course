import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapPage extends StatefulWidget {
  final PlaceLocation location;
  final bool isReadonly;

  const MapPage({
    super.key,
    this.isReadonly = false,
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
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_pickedPosition != null && widget.isReadonly);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select custom location'),
        actions: [
          if (!widget.isReadonly)
            IconButton(
              onPressed: _pickedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPosition);
                    },
              icon: const Icon(Icons.check),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 14,
        ),
        onTap: widget.isReadonly ? null : _selectPosition,
        markers: {
          if (_pickedPosition != null && widget.isReadonly)
            Marker(
              markerId: const MarkerId('id'),
              position: _pickedPosition ?? widget.location.toLatLng(),
            ),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/pages/MapPage.dart';
import 'package:great_places/utils/location_utils.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _imagePreview;

  Future<void> _getCurrentLocation() async {
    final location = await Location().getLocation();

    final staticMap = LocationUtils.getMapPreviewImage(
      latitude: location.latitude ?? 0,
      longitude: location.longitude ?? 0,
    );

    setState(() {
      _imagePreview = staticMap;
    });
  }

  Future<void> _getCustomLocation() async {
    final LatLng? result = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const MapPage(),
      ),
    );

    if (result == null) return;

    print(result.latitude);
    print(result.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imagePreview != null
              ? Image.network(
                  _imagePreview!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text('Without location'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current location'),
            ),
            TextButton.icon(
              onPressed: _getCustomLocation,
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        ),
      ],
    );
  }
}

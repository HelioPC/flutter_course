import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/pages/map_page.dart';

class PlaceDetailPage extends StatelessWidget {
  const PlaceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)?.settings.arguments as Place?;
    return Scaffold(
      appBar: AppBar(
        title: Text(place != null ? place.title : 'No details available'),
      ),
      body: place != null
          ? const Center(
              child: Text('Internal error'),
            )
          : Column(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.file(place!.image, fit: BoxFit.cover),
                ),
                const SizedBox(height: 10),
                Text(
                  place.location.address,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) {
                          return MapPage(
                            isReadonly: true,
                            location: place.location,
                          );
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.map),
                  label: const Text('See on map'),
                ),
              ],
            ),
    );
  }
}

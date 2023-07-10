import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListPage extends StatelessWidget {
  const PlacesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text('My places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.FORMROUTE);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        builder: (context, value, child) {
          return Visibility(
            visible: value.count > 0,
            replacement: child!,
            child: ListView.builder(
              itemCount: value.count,
              itemBuilder: (context, index) {
                final place = value.list[index];

                return ListTile(
                  onTap: () async {
                    await showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      builder: (context) {
                        return const Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [SizedBox(width: double.infinity)],
                        );
                      },
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: FileImage(place.image),
                  ),
                  title: Text(place.title),
                );
              },
            ),
          );
        },
        child: const Center(
          child: Text('No places added'),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormPage extends StatefulWidget {
  const PlaceFormPage({super.key});

  @override
  State<PlaceFormPage> createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _setImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  void _subimtForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New place'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ImageInput(onSelectImage: _setImage),
                      const SizedBox(height: 20),
                      const LocationInput(),
                    ],
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _subimtForm,
                icon: const Icon(Icons.add),
                label: const Text('Add place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

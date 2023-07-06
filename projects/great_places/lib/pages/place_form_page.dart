import 'package:flutter/material.dart';
import 'package:great_places/widgets/image_input.dart';

class PlaceFormPage extends StatefulWidget {
  const PlaceFormPage({super.key});

  @override
  State<PlaceFormPage> createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final _titleController = TextEditingController();

  void _subimtForm() {}

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
                      const ImageInput(),
                    ],
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _subimtForm,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

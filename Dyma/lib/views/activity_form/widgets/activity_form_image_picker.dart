import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/provider/city_provider.dart';
import 'package:provider/provider.dart';

class ActivityFormImagePicker extends StatefulWidget {
  final Function updateUrl;

  ActivityFormImagePicker({required this.updateUrl});

  @override
  State<ActivityFormImagePicker> createState() =>
      _ActivityFormImagePickerState();
}

class _ActivityFormImagePickerState extends State<ActivityFormImagePicker> {
  File? _deviceImage;

  final ImagePicker imagePicker = ImagePicker();
  Future<void> pickImage(ImageSource source) async {
    final XFile? _pickedFile = await imagePicker.pickImage(source: source);

    _deviceImage = File(_pickedFile!.path);

    if (_deviceImage != null) {
      final url = await Provider.of<CityProvider>(context, listen: false)
          .uploadImage(_deviceImage!);
      print('url final $url');
      widget.updateUrl(url);

      setState(() {});
      print("image OK");
    } else {
      print('no Image');
    }
    try {} catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.photo),
                label: const Text('Galerie'),
                onPressed: () {
                  pickImage(ImageSource.gallery);
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.photo_camera),
                label: const Text('Camera'),
                onPressed: () {
                  print('test');
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: _deviceImage != null
                ? Image.file(_deviceImage!)
                : const Text("Aucune image"),
          )
        ],
      ),
    );
  }
}

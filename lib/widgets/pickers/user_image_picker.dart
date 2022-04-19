import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function imagePickFn;

  const UserImagePicker({required this.imagePickFn, Key? key})
      : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _pickedImage;

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedImage = photo;
    });
    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[400],
          backgroundImage:
              _pickedImage != null ? FileImage(File(_pickedImage!.path)) : null,
        ),
        TextButton.icon(
          icon: const Icon(Icons.image),
          label: const Text("Add Image"),
          onPressed: pickImage,
        ),
      ],
    );
  }
}

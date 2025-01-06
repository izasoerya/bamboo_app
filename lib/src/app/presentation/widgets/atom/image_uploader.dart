import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader extends StatefulWidget {
  final void Function(File)? onImageSelected;
  const ImageUploader({super.key, this.onImageSelected});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _image;
  final ImagePicker _picker = ImagePicker(); // Initialize the image picker

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear, // Rear or front camera
      );
      if (pickedFile != null) {
        File image = File(pickedFile.path);
        setState(() {
          _image = image;
        });
        widget.onImageSelected?.call(image);
        print('Image selected: ${image.path}');
      } else {
        print('No image captured');
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _pickImageFromFileExplorer() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File image = File(pickedFile.path);
        setState(() {
          _image = image;
        });
        widget.onImageSelected?.call(image);
        print('Image selected: ${image.path}');
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _pickImageFromCamera, // Open camera on tap
          child: Container(
            width: 0.125.sw,
            height: 0.1.sw,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.camera_alt,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
        SizedBox(width: 0.025.sw),
        GestureDetector(
          onTap: _pickImageFromFileExplorer, // Open gallery/file explorer
          child: Container(
            width: 0.65.sw,
            height: 0.1.sw,
            padding: EdgeInsets.symmetric(
              horizontal: 0.025.sw,
              vertical: 0.01.sw,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Text(
                _image == null ? 'Upload Image' : _image!.path,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:bamboo_app/src/app/use_cases/file_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageUploader extends StatefulWidget {
  final void Function(File)? onImageSelected;
  const ImageUploader({super.key, this.onImageSelected});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        File? image = await FileController().selectFile();
        if (image != null) {
          print('Image selected: ${image.path}');
          setState(() {
            _image = image;
            widget.onImageSelected!(image);
          });
        } else {
          print('No image selected');
        }
      },
      child: Row(
        children: [
          Container(
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
          SizedBox(width: 0.025.sw),
          Container(
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
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

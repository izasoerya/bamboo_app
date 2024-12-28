import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageHero extends StatelessWidget {
  final String urlImage;
  const ImageHero({super.key, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.55.sw,
      height: 0.31.sw,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }
}

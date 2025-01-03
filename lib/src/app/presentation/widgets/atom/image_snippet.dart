import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageSnippet extends StatelessWidget {
  final String urlImage;
  const ImageSnippet({super.key, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: SizedBox(
            height: 0.8.sh,
            width: 0.8.sw,
            child: Image.network(
              urlImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      child: SizedBox(
        width: 0.55.sw,
        height: 0.31.sw,
        child: urlImage.isNotEmpty
            ? Image.network(
                urlImage,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              )
            : const SizedBox(),
      ),
    );
  }
}

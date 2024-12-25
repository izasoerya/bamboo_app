import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoWindowData extends StatelessWidget {
  final String header;
  final String data;
  const InfoWindowData({super.key, required this.header, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            header,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                ),
            textAlign: TextAlign.center,
          ),
          Text(
            data,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                ),
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(top: 0.02.sh)),
        ],
      ),
    );
  }
}

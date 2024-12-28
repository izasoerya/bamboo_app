import 'package:bamboo_app/src/app/blocs/marker_state.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/image_snippet.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/info_window_data.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/submit_button.dart';
import 'package:bamboo_app/src/app/presentation/widgets/organism/modal_bottom_sheet.dart';
import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInfoWindow extends StatelessWidget {
  final MarkerStateBloc markerStateBloc;
  final EntitiesMarker marker;

  const CustomInfoWindow(
      {super.key, required this.marker, required this.markerStateBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            marker.name,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.025.sh),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              marker.strain.isNotEmpty
                  ? InfoWindowData(header: 'Jenis', data: marker.strain)
                  : const InfoWindowData(header: 'Jenis', data: '-'),
              InfoWindowData(header: 'Quantity', data: marker.qty.toString()),
            ],
          ),
          marker.description.isNotEmpty
              ? InfoWindowData(header: 'Description', data: marker.description)
              : const SizedBox(),
          marker.ownerName.isNotEmpty
              ? InfoWindowData(
                  header: 'Owner Contact',
                  data: '${marker.ownerName} (${marker.ownerContact})')
              : const SizedBox(),
          ImageSnippet(urlImage: marker.urlImage),
          SizedBox(height: 0.025.sh),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SubmitButton(
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext modalContext) => ModalBottomSheet(
                    parentContext: context,
                    uidMarker: marker.uid,
                  ),
                ),
                text: 'Update',
              ),
              SubmitButton(
                onTap: () => Navigator.pop(context),
                text: 'Close',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

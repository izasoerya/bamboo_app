import 'package:bamboo_app/src/app/blocs/marker_state.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/info_window_data.dart';
import 'package:bamboo_app/src/app/presentation/widgets/organism/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInfoWindow extends StatelessWidget {
  final String uidMarker;
  final String name;
  final String description;
  final int qty;
  final String ownerName;
  final String ownerContact;

  const CustomInfoWindow({
    super.key,
    required this.uidMarker,
    required this.name,
    required this.description,
    required this.qty,
    required this.ownerName,
    required this.ownerContact,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MarkerStateBloc(),
      child: BlocBuilder<MarkerStateBloc, MarkerState>(
          builder: (context, snapshot) {
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
                'Deskripsi Data',
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
                  InfoWindowData(header: 'Name', data: name),
                  InfoWindowData(header: 'Quantity', data: qty.toString()),
                ],
              ),
              InfoWindowData(header: 'Description', data: description),
              InfoWindowData(
                  header: 'Owner Contact', data: '$ownerName ($ownerContact)'),
              SizedBox(height: 0.025.sh),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext modalContext) =>
                            ModalBottomSheet(
                          parentContext: context,
                          uidMarker: uidMarker,
                        ),
                      );
                    },
                    child: const Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

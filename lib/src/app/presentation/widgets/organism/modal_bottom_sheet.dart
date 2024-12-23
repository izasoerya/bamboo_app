import 'package:bamboo_app/src/app/blocs/marker_state.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/auth_text_field.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/header_auth.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/submit_button.dart';
import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:bamboo_app/utils/default_user.dart';
import 'package:bamboo_app/utils/textfield_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ModalBottomSheet extends StatefulWidget {
  final BuildContext parentContext;

  const ModalBottomSheet({super.key, required this.parentContext});

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0.1.sw),
      child: Column(
        children: [
          const HeaderAuth(
            heading: 'Tambahkan Data',
            subheading: 'Tambahkan data lokasi baru',
          ),
          SizedBox(height: 0.03.sh),
          AuthTextField(
            controller: _nameController,
            hintText: 'Name',
            label: 'Name',
            validator: TextfieldValidator.name,
          ),
          SizedBox(height: 0.015.sh),
          AuthTextField(
            controller: _descriptionController,
            hintText: 'Description',
            label: 'Description',
            validator: TextfieldValidator.name,
          ),
          SizedBox(height: 0.03.sh),
          Text(
            'Simpan lokasi ini?',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SubmitButton(
              onTap: () async {
                final position = await Geolocator.getCurrentPosition();
                BlocProvider.of<MarkerStateBloc>(widget.parentContext).add(
                  AddMarkerData(
                    marker: EntitiesMarker(
                      uid: '',
                      uidCreator: defaultUser.uid,
                      uidUser: [defaultUser.uid],
                      name: _nameController.text,
                      description: _descriptionController.text,
                      strain: '',
                      qty: 0,
                      urlImage: '',
                      ownerName: defaultUser.name,
                      ownerContact: defaultUser.email,
                      location: LatLng(position.latitude, position.longitude),
                      createdAt: DateTime.now(),
                    ),
                  ),
                );
                Navigator.pop(context);
              },
              text: 'Tambahkan'),
        ],
      ),
    );
  }
}

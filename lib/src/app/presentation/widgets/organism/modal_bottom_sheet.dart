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
  final String? uidMarker;

  const ModalBottomSheet(
      {super.key, required this.parentContext, this.uidMarker});

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _qtyController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _ownerContactController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
              controller: _qtyController,
              hintText: 'Quantity',
              label: 'Quantity',
              validator: TextfieldValidator.name,
              type: TextInputType.number,
            ),
            SizedBox(height: 0.015.sh),
            AuthTextField(
              controller: _descriptionController,
              hintText: 'Description',
              label: 'Description',
              optional: true,
            ),
            SizedBox(height: 0.015.sh),
            AuthTextField(
              controller: _ownerNameController,
              hintText: 'Nama Pemilik',
              label: 'Nama Pemilik',
              optional: true,
            ),
            SizedBox(height: 0.015.sh),
            AuthTextField(
              controller: _ownerContactController,
              hintText: 'Nomor Pemilik',
              label: 'Nomor Pemilik',
              optional: true,
              type: TextInputType.phone,
            ),
            SizedBox(height: 0.015.sh),
            AuthTextField(
              controller: _latitudeController,
              hintText: 'Latitude',
              label: 'Latitude',
              optional: true,
              type: TextInputType.phone,
            ),
            SizedBox(height: 0.015.sh),
            AuthTextField(
              controller: _longitudeController,
              hintText: 'Longitude',
              label: 'Longitude',
              optional: true,
              type: TextInputType.phone,
            ),
            SizedBox(height: 0.03.sh),
            Text(
              'Simpan lokasi ini?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SubmitButton(
                onTap: () async {
                  final position = await Geolocator.getCurrentPosition();
                  LatLng currentPosition = LatLng(
                    position.latitude,
                    position.longitude,
                  );

                  if (widget.uidMarker == null) {
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
                          ownerName: _ownerNameController.text,
                          ownerContact: _ownerContactController.text,
                          location: _latitudeController.text.isEmpty ||
                                  _longitudeController.text.isEmpty
                              ? currentPosition
                              : LatLng(
                                  double.parse(_latitudeController.text),
                                  double.parse(_longitudeController.text),
                                ),
                          createdAt: DateTime.now(),
                        ),
                      ),
                    );
                  } else {
                    BlocProvider.of<MarkerStateBloc>(widget.parentContext).add(
                      UpdateMarkerData(
                        marker: EntitiesMarker(
                          uid: widget.uidMarker!,
                          uidCreator: defaultUser.uid,
                          uidUser: [defaultUser.uid],
                          name: _nameController.text,
                          description: _descriptionController.text,
                          strain: '',
                          qty: 0,
                          urlImage: '',
                          ownerName: defaultUser.name,
                          ownerContact: defaultUser.email,
                          location: _latitudeController.text.isEmpty ||
                                  _longitudeController.text.isEmpty
                              ? currentPosition
                              : LatLng(
                                  double.parse(_latitudeController.text),
                                  double.parse(_longitudeController.text),
                                ),
                          createdAt: DateTime.now(),
                        ),
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
                text: 'Tambahkan'),
            Padding(
                padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            )),
          ],
        ),
      ),
    );
  }
}

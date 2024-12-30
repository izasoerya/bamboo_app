import 'dart:io';

import 'package:bamboo_app/src/app/blocs/marker_state.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/auth_text_field.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/delete_button.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/header_auth.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/image_uploader.dart';
import 'package:bamboo_app/src/app/presentation/widgets/atom/submit_button.dart';
import 'package:bamboo_app/src/app/routes/routes.dart';
import 'package:bamboo_app/src/app/use_cases/gps_controller.dart';
import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:bamboo_app/src/domain/service/s_marker.dart';
import 'package:bamboo_app/utils/default_user.dart';
import 'package:bamboo_app/utils/textfield_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  File? _image;
  void _onImageChanged(File? image) => _image = image;

  Future<EntitiesMarker>? _markerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.uidMarker != null) {
      _markerFuture = ServiceMarker().fetchMarker(widget.uidMarker!);
      _markerFuture!.then((marker) {
        _nameController.text = marker.name;
        _descriptionController.text = marker.description;
        _qtyController.text = marker.qty.toString();
        _ownerNameController.text = marker.ownerName;
        _ownerContactController.text = marker.ownerContact;
        _latitudeController.text = marker.location.latitude.toString();
        _longitudeController.text = marker.location.longitude.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EntitiesMarker>(
      future: _markerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          EntitiesMarker marker = snapshot.data!;
          return _buildContent(context, marker);
        }
        return _buildContent(context, null);
      },
    );
  }

  Widget _buildContent(BuildContext context, EntitiesMarker? marker) {
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
            _buildTextFields(),
            SizedBox(height: 0.015.sh),
            ImageUploader(onImageSelected: _onImageChanged),
            SizedBox(height: 0.03.sh),
            Text(
              'Simpan lokasi ini?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            _buildSubmitButton(marker),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildSubmitButton(EntitiesMarker? marker) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        SubmitButton(
          onTap: () async {
            final position = await GpsController().getCurrentPosition();
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
                    qty: int.tryParse(_qtyController.text) ?? 0,
                    urlImage: _image == null ? '' : _image!.path,
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
                    uid: marker!.uid,
                    uidCreator: marker.uidCreator,
                    uidUser: marker.uidUser,
                    name: _nameController.text.isEmpty
                        ? marker.name
                        : _nameController.text,
                    description: _descriptionController.text.isEmpty
                        ? marker.description
                        : _descriptionController.text,
                    strain: '',
                    qty: _qtyController.text.isEmpty
                        ? marker.qty
                        : int.parse(_qtyController.text),
                    urlImage: _image == null
                        ? 'NULL:${marker.urlImage}'
                        : _image!.path,
                    ownerName: _ownerNameController.text.isEmpty
                        ? marker.ownerName
                        : _ownerNameController.text,
                    ownerContact: _ownerContactController.text.isEmpty
                        ? marker.ownerContact
                        : _ownerContactController.text,
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
            if (widget.uidMarker == null) {
              router.pop();
            } else {
              router.pop();
              router.pop();
            }
          },
          text: 'Tambahkan',
        ),
        const Spacer(),
        widget.uidMarker != null ? DeleteButton(onTap: () {}) : const Spacer(),
      ],
    );
  }
}

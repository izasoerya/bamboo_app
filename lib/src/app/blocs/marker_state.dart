import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:bamboo_app/src/domain/service/s_marker.dart';
import 'package:bamboo_app/utils/default_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MarkerEvent {}

class FetchMarkerData extends MarkerEvent {}

class AddMarkerData extends MarkerEvent {
  final EntitiesMarker marker;

  AddMarkerData({required this.marker});
}

class UpdateMarkerData extends MarkerEvent {
  final EntitiesMarker marker;

  UpdateMarkerData({required this.marker});
}

class DeleteMarkerData extends MarkerEvent {
  final EntitiesMarker marker;

  DeleteMarkerData({required this.marker});
}

class MarkerState {
  final Set<EntitiesMarker> markers;

  MarkerState({required this.markers});
}

class MarkerStateBloc extends Bloc<MarkerEvent, MarkerState> {
  MarkerStateBloc() : super(MarkerState(markers: {})) {
    on<FetchMarkerData>((event, emit) async {
      final markers = await ServiceMarker().fetchListMarker(defaultUser.uid);
      emit(MarkerState(markers: markers));
    });

    on<AddMarkerData>((event, emit) async {
      await ServiceMarker().addMarker(event.marker);
      final markers = await ServiceMarker().fetchListMarker(defaultUser.uid);

      emit(MarkerState(markers: markers));
    });

    on<UpdateMarkerData>((event, emit) async {
      await ServiceMarker().updateMarker(event.marker);
      final markers = await ServiceMarker().fetchListMarker(defaultUser.uid);

      emit(MarkerState(markers: markers));
    });

    on<DeleteMarkerData>((event, emit) async {
      await ServiceMarker().deleteMarker(event.marker);
      final markers = await ServiceMarker().fetchListMarker(defaultUser.uid);

      emit(MarkerState(markers: markers));
    });
  }
}

import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:bamboo_app/src/domain/service/s_marker.dart';
import 'package:bamboo_app/utils/default_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MarkerEvent {}

class FetchMarkerData extends MarkerEvent {}

class MarkerState {
  final Set<EntitiesMarker> markers;

  MarkerState({required this.markers});
}

class MarkerStateBloc extends Bloc<MarkerEvent, MarkerState> {
  MarkerStateBloc() : super(MarkerState(markers: {})) {
    on<FetchMarkerData>((event, emit) async {
      final markers = await ServiceMarker().fetchPolygon(defaultUser.uid);

      emit(MarkerState(markers: markers));
    });
  }
}

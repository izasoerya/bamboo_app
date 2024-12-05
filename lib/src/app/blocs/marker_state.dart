import 'package:bamboo_app/src/domain/entities/e_marker.dart';
import 'package:bamboo_app/src/domain/service/s_marker.dart';
import 'package:bamboo_app/utils/default_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MarkerEvent {}

class FetchMarkerData extends MarkerEvent {}

class MarkerState {
  final List<EntitiesMarker?> polygons;

  MarkerState({required this.polygons});
}

class MarkerStateBloc extends Bloc<MarkerEvent, MarkerState> {
  MarkerStateBloc() : super(MarkerState(polygons: [])) {
    on<FetchMarkerData>((event, emit) async {
      final polygons = await ServiceMarker().fetchPolygon(defaultUser.uid);
      emit(MarkerState(polygons: polygons));
    });
  }
}

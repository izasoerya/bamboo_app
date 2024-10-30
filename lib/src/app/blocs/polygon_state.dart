import 'package:bamboo_app/src/domain/entities/e_polygon.dart';
import 'package:bamboo_app/src/domain/service/s_polygon.dart';
import 'package:bamboo_app/utils/default_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PolygonEvent {}

class FetchPolygonData extends PolygonEvent {}

class PolygonState {
  final List<EntitiesPolygon?> polygons;

  PolygonState({required this.polygons});
}

class PolygonStateBloc extends Bloc<PolygonEvent, PolygonState> {
  PolygonStateBloc() : super(PolygonState(polygons: [])) {
    on<FetchPolygonData>((event, emit) async {
      final polygons = await ServicePolygon().fetchPolygon(defaultUser.uid);
      emit(PolygonState(polygons: polygons));
    });
  }
}

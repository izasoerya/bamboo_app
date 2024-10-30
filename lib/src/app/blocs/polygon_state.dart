import 'package:bamboo_app/src/domain/entities/e_polygon.dart';
import 'package:bamboo_app/src/domain/infrastructure/i_polygon.dart';
import 'package:bamboo_app/utils/default_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PolygonEvent {}

class TogglePolygonEvent extends PolygonEvent {}

class FetchPolygonData extends PolygonEvent {}

class PolygonState {
  final List<EntitiesPolygon?> polygons;

  PolygonState({required this.polygons});
}

class PolygonStateBloc extends Bloc<PolygonEvent, PolygonState> {
  PolygonStateBloc() : super(PolygonState(polygons: [])) {
    on<TogglePolygonEvent>((event, emit) {
      emit(PolygonState(polygons: state.polygons));
    });
    on<FetchPolygonData>((event, emit) async {
      final polygons =
          await InfrastructurePolygon().readPolygons(defaultUser.uid);
      emit(PolygonState(polygons: polygons));
    });
  }
}

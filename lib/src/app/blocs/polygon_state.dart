import 'package:bamboo_app/src/domain/entities/e_polygon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PolygonEvent {}

class TogglePolygonEvent extends PolygonEvent {}

class PolygonState {
  final List<EntitiesPolygon> polygons;

  PolygonState({required this.polygons});
}

class PolygonStateBloc extends Bloc<PolygonEvent, PolygonState> {
  PolygonStateBloc() : super(PolygonState(polygons: [])) {
    on<TogglePolygonEvent>((event, emit) {
      emit(PolygonState(polygons: state.polygons));
    });
  }
}

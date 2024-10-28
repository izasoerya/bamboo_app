import 'package:bamboo_app/src/domain/entities/e_user.dart';
import 'package:bamboo_app/utils/default_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserLoggedEvent {}

class ToggleUserLoggedInEvent extends UserLoggedEvent {
  final EntitiesUser user;

  ToggleUserLoggedInEvent({required this.user});
}

class UserLoggedState {
  bool isLogged;
  EntitiesUser user;

  UserLoggedState({required this.isLogged, required this.user});
}

class UserLoggedStateBloc extends Bloc<UserLoggedEvent, UserLoggedState> {
  UserLoggedStateBloc()
      : super(UserLoggedState(isLogged: false, user: defaultUser)) {
    on<ToggleUserLoggedInEvent>((event, emit) {
      emit(UserLoggedState(isLogged: !state.isLogged, user: event.user));
    });
  }
}

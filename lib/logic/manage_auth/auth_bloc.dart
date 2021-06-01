import 'dart:async';

import 'package:aula09_2021/auth_provider/firebase_auth.dart';
import 'package:aula09_2021/logic/manage_auth/auth_event.dart';
import 'package:aula09_2021/logic/manage_auth/auth_state.dart';
import 'package:aula09_2021/model/user.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseAuthenticationService _authenticationService;
  StreamSubscription _authenticationStream;

  AuthBloc() : super(Unauthenticated()) {
    _authenticationService = FirebaseAuthenticationService();

    _authenticationStream =
        _authenticationService.user.listen((UserModel userModel) {
      add(InnerServerEvent(userModel));
    });
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event == null) {
      yield Unauthenticated();
    } else if (event is LoginAnonymousUser) {
      _authenticationService.signInAnonimo();
    } else if (event is InnerServerEvent) {
      if (event.userModel == null) {
        yield Unauthenticated();
      } else {
        yield Authenticated(user: event.userModel);
      }
    } else if (event is Logout) {
      _authenticationService.signOut();
    }
  }
}

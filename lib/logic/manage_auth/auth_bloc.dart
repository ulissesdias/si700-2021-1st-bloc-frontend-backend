import 'dart:async';

import 'package:aula09_2021/auth_provider/firebase_auth.dart';
import 'package:aula09_2021/data/firebase/firebase_database.dart';
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
    try {
      if (event == null) {
        yield Unauthenticated();
      } else if (event is RegisterUser) {
        await _authenticationService.createUserWithEmailAndPassword(
            email: event.username, password: event.password);
      } else if (event is LoginAnonymousUser) {
        await _authenticationService.signInAnonimo();
      } else if (event is LoginUser) {
        await _authenticationService.signInWithEmailAndPassword(
            email: event.username, password: event.password);
      } else if (event is InnerServerEvent) {
        if (event.userModel == null) {
          yield Unauthenticated();
        } else {
          FirebaseRemoteServer.uid = event.userModel.uid;
          yield Authenticated(user: event.userModel);
        }
      } else if (event is Logout) {
        await _authenticationService.signOut();
      }
    } catch (e) {
      yield AuthError(message: e.toString());
    }
  }
}

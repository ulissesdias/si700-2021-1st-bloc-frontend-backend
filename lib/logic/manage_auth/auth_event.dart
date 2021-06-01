import 'package:aula09_2021/model/user.dart';

abstract class AuthEvent {}

class RegisterUser extends AuthEvent {
  String username;
  String password;
}

class LoginUser extends AuthEvent {
  String username;
  String password;
}

class LoginAnonymousUser extends AuthEvent {}

class Logout extends AuthEvent {}

class InnerServerEvent extends AuthEvent {
  final UserModel userModel;
  InnerServerEvent(this.userModel);
}

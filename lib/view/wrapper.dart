import 'package:aula09_2021/view/notes/my_app_screen.dart';
import 'package:flutter/material.dart';

import 'auth/authentication_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return MyApp();
    return AuthenticationScreen();
  }
}

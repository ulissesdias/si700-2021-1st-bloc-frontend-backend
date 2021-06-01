import 'package:aula09_2021/logic/manage_auth/auth_bloc.dart';
import 'package:aula09_2021/logic/manage_auth/auth_state.dart';
import 'package:aula09_2021/view/notes/my_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/authentication_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return MyApp();
    //return AuthenticationScreen();
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state is Authenticated) {
          return MyApp();
        } else {
          return AuthenticationScreen();
        }
      },
      listener: (context, state) {
        if (state is AuthError) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Erro do Servidor"),
                  content: Text("${state.message}"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Ok"))
                  ],
                );
              });
        }
      },
    );
  }
}

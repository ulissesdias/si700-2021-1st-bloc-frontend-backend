import 'package:aula09_2021/view/auth/register.dart';
import 'package:aula09_2021/view/auth/sign_in.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthenticationScreenStatex();
  }
}

class _AuthenticationScreenStatex extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              Register(),
              SignIn(),
            ],
          ),
          appBar: AppBar(
            title: Text("Configuração de Usuários"),
            bottom: TabBar(
              tabs: [Tab(text: "Novo Registro"), Tab(text: "Efetuar Login")],
            ),
          ),
        ));
  }
}

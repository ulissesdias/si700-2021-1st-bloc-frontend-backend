import 'package:aula09_2021/logic/manage_auth/auth_bloc.dart';
import 'package:aula09_2021/logic/manage_auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return signInFormulario();
  }

  Widget signInFormulario() {
    final GlobalKey<FormState> formKey = new GlobalKey();
    final LoginUser loginData = new LoginUser(); // evento;
    return Form(
        key: formKey,
        child: Column(children: [
          TextFormField(
              initialValue: "",
              keyboardType: TextInputType.emailAddress,
              validator: (String inValue) {
                if (inValue.length == 0) {
                  return "Please enter username";
                }
                return null;
              },
              onSaved: (String inValue) {
                loginData.username = inValue;
              },
              decoration: InputDecoration(
                  hintText: "none@none.com",
                  labelText: "Username (eMail address)")),
          TextFormField(
              initialValue: "",
              obscureText: true,
              validator: (String inValue) {
                if (inValue.length < 1) {
                  return "Password must be >=10 in length";
                }
                return null;
              },
              onSaved: (String inValue) {
                loginData.password = inValue;
              },
              decoration:
                  InputDecoration(hintText: "Password", labelText: "Password")),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  BlocProvider.of<AuthBloc>(context).add(loginData);
                }
              },
              child: Text("SignIn!")),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LoginAnonymousUser());
              },
              child: Text("SignInAnônimo!"))
        ]));
  }
}

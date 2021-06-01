import 'package:flutter/material.dart';

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
              onSaved: (String inValue) {},
              decoration: InputDecoration(
                  hintText: "none@none.com",
                  labelText: "Username (eMail address)")),
          TextFormField(
              initialValue: "a",
              obscureText: true,
              validator: (String inValue) {
                if (inValue.length < 10) {
                  return "Password must be >=10 in length";
                }
                return null;
              },
              onSaved: (String inValue) {},
              decoration:
                  InputDecoration(hintText: "Password", labelText: "Password")),
          ElevatedButton(onPressed: () {}, child: Text("SignIn!"))
        ]));
  }
}

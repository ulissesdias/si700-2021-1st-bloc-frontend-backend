import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return registerFormulario();
  }

  Widget registerFormulario() {
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
          ElevatedButton(onPressed: () {}, child: Text("Register!"))
        ]));
  }
}

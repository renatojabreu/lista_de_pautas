import 'package:flutter/material.dart';
import 'package:lista_de_pautas/Screens/home_screen.dart';
import 'package:lista_de_pautas/Screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Criar conta",
              style: TextStyle(fontSize: 15.0),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Email"),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text.isEmpty || !text.contains("@"))
                  return "e-mail inválido";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
                decoration: InputDecoration(hintText: "Senha"),
                obscureText: true,
                validator: (text) {
                  if (text.isEmpty || text.length < 6) return "senha inválida";
                }),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text("Esqueci minha senha", textAlign: TextAlign.right),
                padding: EdgeInsets.zero,
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
                height: 48.0,
                child: RaisedButton(
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}

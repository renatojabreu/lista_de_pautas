import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_pautas/Screens/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  void signUp(Map<String, dynamic> userData, String pass,
      VoidCallback onSuccess, VoidCallback onFail,
      {Map}) {
    isLoading = true;
    //notifyListeners();

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) {
      firebaseUser = user as FirebaseUser;

      onSuccess();
      isLoading = false;
    }).catchError((e) {
      onFail();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Voltar",
              style: TextStyle(fontSize: 15.0),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
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
              controller: _nameController,
              decoration: InputDecoration(hintText: "Nome Completo"),
              validator: (text) {
                if (text.isEmpty) return "Nome inválido";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: _emailController,
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
                controller: _passController,
                decoration: InputDecoration(hintText: "Senha"),
                obscureText: true,
                validator: (text) {
                  if (text.isEmpty || text.length < 6) return "senha inválida";
                }),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
                height: 48.0,
                child: RaisedButton(
                  child: Text(
                    "Criar conta",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Map<String, dynamic> userData = {
                        "name": _nameController.text,
                        "email": _emailController.text,
                      };
                      //  signUp(userData: userData,
                      //  pass: _passController.text,
                      //  onSuccess: _onSuccess,
                      //  onFail: _onFail);
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}

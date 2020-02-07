import 'package:flutter/material.dart';
import 'package:lista_de_pautas/Screens/signup_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/home_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lista de Pautas",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color.fromARGB(255, 4, 125, 140)),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

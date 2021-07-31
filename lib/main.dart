import 'package:flutter/material.dart';
import 'package:flutter_authen/screens/home.dart';
import 'package:flutter_authen/screens/login.dart';
import 'package:flutter_authen/screens/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => Login(),
        '/signUp': (context) => SignUp(),
        '/home': (context) => HomePage()
      },
    );
  }
}

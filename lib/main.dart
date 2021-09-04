import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authen/providers/UserProvider.dart';
import 'package:flutter_authen/providers/ImageProvider.dart';
import 'package:flutter_authen/screens/home.dart';
import 'package:flutter_authen/screens/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ChangeNotifierProvider<ImgProvider>(create: (_) => ImgProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user != null ? HomePage() : Login(),
      // routes: {
      //   '/': (context) => Login(),
      //   '/signUp': (context) => SignUp(),
      //   '/home': (context) => HomePage()
      // },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_authen/widgets/drawerList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Beepee's Cactus"),
        ),
        drawer: Drawer(
          child: DrawerList(),
        ),
        body: null);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_authen/modules/image_picker.dart';
import 'package:flutter_authen/widgets/drawerList.dart';
import 'package:flutter_authen/widgets/imageList.dart';

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
      body: Container(
        child: Center(
          child: ImageList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ImagePickers().pickImage(context);
          setState(() {});
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

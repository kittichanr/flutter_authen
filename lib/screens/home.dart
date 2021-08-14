import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_authen/modules/image_picker.dart';
import 'package:flutter_authen/widgets/drawerList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imageUrl;

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
          child: imageUrl != null ? Image.file(imageUrl!) : Text('no image'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          File? image = await ImagePickers().pickImage();
          setState(() {
            if (image != null) {
              imageUrl = image;
            }
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

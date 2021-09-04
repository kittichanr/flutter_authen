import 'package:flutter/material.dart';
import 'package:flutter_authen/modules/image_picker.dart';
import 'package:flutter_authen/providers/ImageProvider.dart';
import 'package:flutter_authen/widgets/drawerList.dart';
import 'package:flutter_authen/widgets/imageList.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ImgProvider imageProvider = Provider.of<ImgProvider>(context);
    List<Map<String, dynamic>> selectedList = imageProvider.selectedList;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Beepee's Cactus"),
        actions: selectedList.length > 0
            ? <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        imageProvider.saveSelectedImage();
                      },
                      child: Icon(
                        Icons.save,
                        size: 26.0,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        imageProvider.deleteSelectedImage();
                      },
                      child: Icon(Icons.delete),
                    )),
              ]
            : [],
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

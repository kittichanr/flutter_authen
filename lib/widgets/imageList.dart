import 'package:flutter/material.dart';
import 'package:flutter_authen/modules/fire_storage.dart';

class ImageList extends StatelessWidget {
  const ImageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> imageList = FireStorage().getImageList();

    return FutureBuilder(
        future: imageList,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> image = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      dense: false,
                      leading: Image.network(image['url']),
                      title: Text(image['uploaded_by']),
                      subtitle: Text(image['description']),
                      trailing: IconButton(
                        onPressed: () => {},
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_authen/providers/ImageProvider.dart';
import 'package:flutter_authen/widgets/gridItem.dart';
import 'package:provider/provider.dart';

class ImageList extends StatefulWidget {
  const ImageList({Key? key}) : super(key: key);

  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  @override
  void initState() {
    super.initState();
    context.read<ImgProvider>().fetchImageList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<ImgProvider>().imageList,
        builder: (_, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (_, index) {
                  final Map<String, dynamic> image = snapshot.data![index];
                  return GridItem(
                      item: image,
                      isSelected: (bool value) {
                        setState(() {
                          if (value) {
                            context.read<ImgProvider>().addSelectImage(image);
                          } else {
                            context
                                .read<ImgProvider>()
                                .removeSelectImage(image);
                          }
                        });
                      },
                      key: Key(snapshot.data![index].toString()));
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

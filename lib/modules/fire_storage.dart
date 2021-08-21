import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<Map<String, dynamic>>> getImageList() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref('uploads/').listAll();
    final List<Reference> allFiles = result.items;
    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }
}

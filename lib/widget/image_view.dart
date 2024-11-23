import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  final Future imageFile;
  const ImageView({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: imageFile.then((value) => value!),
          builder: (_, snapshot) {
            final file = snapshot.data;
            if (file == null) return Container();
            return PhotoView(
              imageProvider: FileImage(file),
            );
          }),
    );
  }
}

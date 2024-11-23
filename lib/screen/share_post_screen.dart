import 'dart:io';

import 'package:flutter/material.dart';

class SharePostScreen extends StatelessWidget {
  final File imageFile;
  const SharePostScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Image.file(imageFile);
  }
}

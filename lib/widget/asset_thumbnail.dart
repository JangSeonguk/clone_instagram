import 'package:baby_stamp/widget/image_view.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';

class AssetThumbnail extends StatefulWidget {
  final AssetEntity asset;
  const AssetThumbnail({super.key, required this.asset});

  @override
  State<AssetThumbnail> createState() => _AssetThumbnailState();
}

class _AssetThumbnailState extends State<AssetThumbnail> {
  static final Map<String, Uint8List> _cache = {};

  Future<Uint8List> _getThumbData() async {
    if (_cache.containsKey(widget.asset.id)) {
      return _cache[widget.asset.id]!;
    }

    final data = await widget.asset.thumbnailData;
    if (data != null) {
      _cache[widget.asset.id] = data;
    }
    return data!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _getThumbData(),
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        if (bytes == null) return const CircularProgressIndicator();
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ImageView(imageFile: widget.asset.file),
              ),
            );
          },
          child: Image.memory(
            bytes,
            fit: BoxFit.cover,
            scale: 0.1,
          ),
        );
      },
    );
  }
}

import 'package:baby_stamp/constants/common_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundedAvatar extends StatelessWidget {
  final double size;
  const RoundedAvatar({
    super.key,
    this.size = avatarSize,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: "https://picsum.photos/100",
        width: size,
        height: size,
      ),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final int index;
  const Post(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _postHeader(),
        _postImage(),
      ],
    );
  }

  Widget _postHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: "https://picsum.photos/100",
              width: 30,
              height: 30,
            ),
          ),
        ),
        const Expanded(child: Text("username")),
        const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black87,
            ))
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
      imageUrl: "https://picsum.photos/id/$index/200/200",
      imageBuilder: (context, imageProvider) {
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
        );
      },
      placeholder: (context, url) => const LinearProgressIndicator(
        color: Colors.black,
        backgroundColor: Colors.grey,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

import 'package:baby_stamp/widget/comment.dart';
import 'package:baby_stamp/widget/rounded_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:baby_stamp/constants/common_size.dart';

class Post extends StatelessWidget {
  final int index;
  const Post(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption(),
      ],
    );
  }

  Widget _postCaption() {
    return const Padding(
      padding:
          EdgeInsets.symmetric(horizontal: commonGap, vertical: commonXxsGap),
      child: Comment(
        showImage: false,
        username: 'testingUser',
        text: 'I have money!!',
      ),
    );
  }

  Padding _postLikes() {
    return const Padding(
      padding: EdgeInsets.only(left: commonGap),
      child: Text(
        "12000 likes",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postActions() {
    return const Row(
      children: [
        IconButton(
            onPressed: null,
            icon: Icon(
              Icons.bookmark,
              color: Colors.black87,
            )),
        IconButton(
            onPressed: null,
            icon: Icon(
              Icons.comment,
              color: Colors.black87,
            )),
        IconButton(
            onPressed: null,
            icon: Icon(
              Icons.send,
              color: Colors.black87,
            )),
        Spacer(),
        IconButton(
            onPressed: null,
            icon: Icon(
              Icons.favorite,
              color: Colors.black87,
            )),
      ],
    );
  }

  Widget _postHeader() {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.all(commonXxsGap),
          child: RoundedAvatar(),
        ),
        Expanded(child: Text("username")),
        IconButton(
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

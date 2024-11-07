import 'package:baby_stamp/widget/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        leading: IconButton(
            onPressed: null,
            icon: Icon(
              Icons.photo_camera_rounded,
              color: Colors.black,
            )),
        middle: Text(
          "Instagram",
          style: TextStyle(
              fontFamily: 'VeganStyle', fontWeight: FontWeight.normal),
        ),
      ),
      body: ListView.builder(
        itemBuilder: feedListBuilder,
        itemCount: 10,
      ),
    );
  }

  Widget feedListBuilder(BuildContext context, int index) {
    return Post(index);
  }
}

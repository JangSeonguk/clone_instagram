import 'package:baby_stamp/constants/common_size.dart';
import 'package:baby_stamp/widget/rounded_avatar.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final bool showImage;
  final String username;
  final String text;
  final DateTime? dateTime;

  const Comment({
    super.key,
    this.showImage = true,
    required this.username,
    required this.text,
    this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showImage) const RoundedAvatar(size: 24),
        if (showImage) const SizedBox(width: commonXxsGap),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                //TextSpan은 main에서 설정된 theme 컬러가 기본값이다.
                text: TextSpan(children: [
              TextSpan(
                  text: username,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              const TextSpan(text: "  "),
              const TextSpan(
                  text: 'I love myself!!!',
                  style: TextStyle(color: Colors.black)),
            ])),
            if (dateTime != null)
              Text(
                dateTime?.toIso8601String() ?? 'Unknown date',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 10,
                ),
              )
          ],
        ),
      ],
    );
  }
}

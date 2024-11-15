import 'package:baby_stamp/constants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TakePhoto extends StatelessWidget {
  const TakePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: screenSize.width,
        height: screenSize.width,
        color: Colors.black,
      ),
      Expanded(
          child: SizedBox(
        height: 100,
        width: 100,
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              side: const BorderSide(width: 20, color: Colors.grey)),
          child: const Text(""),
        ),
      ))
    ]);
  }
}

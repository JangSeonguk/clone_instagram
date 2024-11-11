import 'package:baby_stamp/widget/profile_body.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appbar(),
            const ProfileBody(),
          ],
        ),
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: [
        const SizedBox(
          width: 44,
        ),
        const Expanded(
            child: Text(
          "Jang's gram",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        )),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        )
      ],
    );
  }
}

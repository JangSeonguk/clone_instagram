import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 10, right: 20),
          child: const Divider(
            height: 30,
          ),
        )),
        Text(
          "OR",
          style: TextStyle(color: Colors.grey[500]),
        ),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 20, right: 10),
          child: const Divider(
            height: 30,
          ),
        )),
      ],
    );
  }
}

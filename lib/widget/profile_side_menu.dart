import 'package:flutter/material.dart';

class ProfileSideMenu extends StatelessWidget {
  final double menuWidth;
  const ProfileSideMenu({super.key, required this.menuWidth});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: menuWidth,
        child: const Column(
          children: [
            ListTile(
              title: Text(
                "Setting",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black87,
              ),
              title: Text("Sign Out"),
            )
          ],
        ),
      ),
    );
  }
}

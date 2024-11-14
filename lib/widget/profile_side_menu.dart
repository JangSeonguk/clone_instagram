import 'package:baby_stamp/screen/auth_screen.dart';
import 'package:baby_stamp/widget/sign_in_form.dart';
import 'package:flutter/material.dart';

class ProfileSideMenu extends StatelessWidget {
  final double menuWidth;
  const ProfileSideMenu({super.key, required this.menuWidth});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: menuWidth,
        child: Column(
          children: [
            const ListTile(
              title: Text(
                "Setting",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AuthScreen()));
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.black87,
              ),
              title: const Text("Sign Out"),
            )
          ],
        ),
      ),
    );
  }
}

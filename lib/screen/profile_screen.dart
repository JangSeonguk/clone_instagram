import 'package:baby_stamp/constants/screen_size.dart';
import 'package:baby_stamp/widget/profile_body.dart';
import 'package:baby_stamp/widget/profile_side_menu.dart';
import 'package:flutter/material.dart';

const duration = Duration(milliseconds: 1000);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final menuWidth = screenSize.width / 3 * 2;

  MenuStatus _menuStatus = MenuStatus.closed;
  double bodyXPos = 0;
  double menuXPos = screenSize.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(children: [
        AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          duration: duration,
          transform: Matrix4.translationValues(bodyXPos, 0, 0),
          child: ProfileBody(onMenuChanged: () {
            setState(() {
              _menuStatus = (_menuStatus == MenuStatus.closed)
                  ? MenuStatus.opend
                  : MenuStatus.closed;

              switch (_menuStatus) {
                case MenuStatus.closed:
                  menuXPos = screenSize.width;
                  bodyXPos = 0;
                  break;
                case MenuStatus.opend:
                  menuXPos = screenSize.width - menuWidth;
                  bodyXPos = -menuWidth;
                  break;
              }
            });
          }),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          width: screenSize.width / 2,
          child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: duration,
              transform: Matrix4.translationValues(menuXPos, 0, 0),
              child: ProfileSideMenu(menuWidth: menuWidth)),
        ),
      ]),
    );
  }
}

enum MenuStatus { opend, closed }

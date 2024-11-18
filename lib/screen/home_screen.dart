import 'package:app_settings/app_settings.dart';
import 'package:baby_stamp/screen/camera_screen.dart';
import 'package:baby_stamp/screen/feed_screen.dart';
import 'package:baby_stamp/screen/profile_screen.dart';
import 'package:baby_stamp/constants/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<BottomNavigationBarItem> btmNavItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
    const BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
    const BottomNavigationBarItem(icon: Icon(Icons.healing), label: "Healing"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle), label: "Account"),
  ];

  int _selectedIndex = 0;
  // final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static final List<Widget> _screens = <Widget>[
    const FeedScreen(),
    Container(
      color: Colors.blueAccent,
    ),
    Container(
      color: Colors.black,
    ),
    Container(
      color: Colors.grey,
    ),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: btmNavItems,
          showSelectedLabels: false,
          selectedIconTheme: const IconThemeData(size: 35),
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: _onBtmItemClick,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ));
  }

  void _onBtmItemClick(int index) {
    switch (index) {
      case 2:
        _openCamera();
        break;
      default:
        {
          setState(() {
            _selectedIndex = index;
          });
        }
    }
  }

  void _openCamera() async {
    // 현재 위젯이 유효한 상태인지 확인하는 조건 추가
    if (!mounted) return;

    // 권한 확인
    bool isPermissionGranted = await checkIfPermissionGranted(context);

    // 권한이 허용되었고, 여전히 위젯이 유효한 경우 카메라 화면으로 이동
    if (isPermissionGranted && mounted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const CameraScreen()));
    } else {
      if (!mounted) return;

      SnackBar snackBar = SnackBar(
        content: const Text("사진, 파일, 마이크 접근 권한을 허용해주세요."),
        action: SnackBarAction(
            label: "OK",
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              AppSettings.openAppSettings();
            }),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.camera, Permission.microphone].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) permitted = false;
    });
    return permitted;
  }
}

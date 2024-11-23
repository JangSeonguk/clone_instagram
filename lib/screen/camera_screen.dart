import 'package:baby_stamp/models/camera_state.dart';
import 'package:baby_stamp/screen/profile_screen.dart';
import 'package:baby_stamp/widget/my_gallery.dart';
import 'package:baby_stamp/widget/take_photo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  final CameraState _cameraState = CameraState();

  CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int _selectedIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);
  String _title = "Photo";

  @override
  void initState() {
    widget._cameraState.getReadyToTakePhoto();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    widget._cameraState.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(_selectedIndex,
          duration: duration, curve: Curves.fastOutSlowIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: widget._cameraState)],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_title),
        ),
        body: PageView(
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
              switch (_selectedIndex) {
                case 0:
                  _title = "Gallery";
                  break;
                case 1:
                  _title = "Photo";
                  break;
                case 2:
                  _title = "Video";
                  break;
              }
            });
          },
          controller: _pageController,
          children: [
            const MyGallery(),
            const TakePhoto(),
            Container(
              color: Colors.green,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Gallery"),
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Camera"),
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Video"),
          ],
          currentIndex: _selectedIndex,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          selectedItemColor: Colors.black,
          selectedFontSize: 15,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

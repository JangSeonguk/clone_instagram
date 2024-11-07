import 'package:baby_stamp/screen/feed_screen.dart';
import 'package:flutter/material.dart';

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

  static final List<Widget> _screens = <Widget>[
    const FeedScreen(),
    Container(
      color: Colors.blueAccent,
    ),
    Container(
      color: Colors.purpleAccent,
    ),
    Container(
      color: Colors.grey,
    ),
    Container(
      color: Colors.greenAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
    setState(() {
      _selectedIndex = index;
    });
  }
}

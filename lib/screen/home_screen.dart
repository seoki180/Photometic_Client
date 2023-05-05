import 'package:flutter/material.dart';
import 'package:photometic/tabs/home_tab.dart';
import 'package:photometic/tabs/profile_drawer_tab.dart';
import 'package:photometic/tabs/map_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int _currentIndex = 1;
  final List _tabList = [
    const ProfileDrawer(),
    const HomeTab(),
    const MapTab(),
  ];

  _onTapItem(int index) {
    index == 0
        ? _drawerKey.currentState!.openDrawer()
        : setState(() {
            _currentIndex = index;
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const Drawer(
        child: ProfileDrawer(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red[200],
        unselectedItemColor: Colors.black38,
        currentIndex: _currentIndex,
        onTap: _onTapItem,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: "프로필",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "메인화면",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: "지도",
          ),
        ],
      ),
      body: _tabList[_currentIndex],
    );
  }
}

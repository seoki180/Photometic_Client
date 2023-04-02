import 'package:flutter/material.dart';
import 'package:photometic/providers/photos_provider.dart';
import 'package:photometic/providers/user_provider.dart';
import 'package:photometic/tabs/home_tab.dart';
import 'package:photometic/tabs/profile_drawer_tab.dart';
import 'package:photometic/tabs/profile_tab.dart';
import 'package:provider/provider.dart';

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
    const ProfileTab(),
    const HomeTab(),
    const ProfileTab(),
  ];

  _onTapItem(int index) {
    index == 0
        ? _drawerKey.currentState!.openDrawer()
        : setState(() {
            _currentIndex = index;
          });
  }

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final photosProvider = Provider.of<PhotosProvider>(context, listen: false);
    userProvider.getProfile();
    photosProvider.getPhotos();
    super.initState();
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
                icon: Icon(Icons.account_circle_rounded), label: "프로필"),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "메인화면",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.wallpaper_outlined), label: "사진화면"),
          ],
        ),
        body: Container(
          child: _tabList[_currentIndex],
        ));
  }
}

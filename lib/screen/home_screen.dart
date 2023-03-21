import 'package:flutter/material.dart';
import 'package:photometic/tabs/main_tab.dart';
import 'package:photometic/tabs/photos_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentTab = 0;
  final List<Widget> _tabs = [
    const HomeTab(),
    const PhotoTab(),
  ];

  void onTapTab(index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(),
      ),
      body: _tabs.elementAt(_currentTab),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: onTapTab,
        selectedIconTheme: const IconThemeData(
          color: Colors.red,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.photo_album), label: "home"),
        ],
      ),
    );
  }
}

// Builder(builder = (context) {
//               return IconButton(
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//                 icon: const Icon(Icons.list_outlined),
//               );
//             }),

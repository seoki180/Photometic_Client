import 'package:flutter/material.dart';
import 'package:photometic/tabs/main_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final int _currentTab = 0;
  final List<Widget> _tab = [
    const HomeTab(),
    const HomeTab(),
    const HomeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(),
      ),
      body: const HomeTab(),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm_outlined), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm_outlined), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm_outlined), label: "home"),
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

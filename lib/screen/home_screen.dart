import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:photometic/providers/user_provider.dart';
import 'package:provider/provider.dart';

const storage = FlutterSecureStorage();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserProvider>(
              builder: (context, value, child) {
                return Text("hello \n ${value.userCache}");
              },
            ),
            ElevatedButton(
              onPressed: () {
                storage.delete(key: 'token');
                Navigator.of(context).pushReplacementNamed('/start');
              },
              child: const Text("로그아웃"),
            ),
          ],
        ),
      ),
    );
  }
}

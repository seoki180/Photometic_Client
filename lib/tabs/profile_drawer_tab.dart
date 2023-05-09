import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:photometic/providers/user_provider.dart';
import 'package:photometic/repositories/user_repositories.dart';
import 'package:photometic/tabs/profile_setting_tab.dart';
import 'package:provider/provider.dart';

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({
    super.key,
  });

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final userRepositories = UserRepositories();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(userRepositories: userRepositories),
          child: Container(
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Consumer<UserProvider>(
                    builder: (context, value, child) {
                      var profile = value.userCache["userProfile"];
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: profile == null
                            ? const AssetImage(
                                    "assets/images/basic_profile.png")
                                as ImageProvider
                            : NetworkImage(profile),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<UserProvider>(
                          builder: (context, value, child) {
                            var userName = value.userCache["userName"];
                            return Text(
                              "$userName",
                              style: const TextStyle(fontSize: 20),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ListTile(
          title: const Text("계정 설정"),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileSettingTab(),
            ),
          ),
        ),
        ListTile(
          onTap: () => print("환경설정"),
          title: const Text("환경 설정"),
        ),
        ListTile(
          onTap: () {
            storage.delete(key: "token");

            Navigator.pushNamedAndRemoveUntil(
                context, "/start", (route) => false);
          },
          title: const Text("로그 아웃"),
        ),
      ],
    );
  }
}

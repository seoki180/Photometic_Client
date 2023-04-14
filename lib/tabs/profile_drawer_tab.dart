import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:photometic/providers/user_provider.dart';
import 'package:photometic/repositories/user_%20repositories.dart';
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

  final userRepositories = UserRepositories();
  get userProvider => UserProvider(userRepositories: userRepositories);

  // @override
  // void initState() {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   userProvider.getProfile();
  //   super.initState();
  // }

  @override
  void initState() {
    userProvider.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red[200],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 7,
                  child: Consumer<UserProvider>(
                    builder: (context, value, child) {
                      var profile = value.userCache["userProfile"];
                      return CircleAvatar(
                          radius: 40,
                          backgroundImage: profile == ''
                              ? const AssetImage(
                                      "assets/images/basic_profile.png")
                                  as ImageProvider
                              : NetworkImage(profile));
                    },
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<UserProvider>(builder: (context, value, child) {
                        return Text(
                          "${value.userCache["userName"]}",
                          style: const TextStyle(fontSize: 20),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text("계정 설정"),
          onTap: () => print("계정 설정"),
        ),
        ListTile(
          onTap: () => print("환경설정"),
          title: const Text("환경 설정"),
        ),
        ListTile(
          onTap: () {
            storage.delete(key: "token");
            userProvider.logout();

            Navigator.pushNamedAndRemoveUntil(
                context, "/start", (route) => false);
          },
          title: const Text("로그 아웃"),
        ),
      ],
    );
  }
}

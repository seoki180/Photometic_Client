import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photometic/providers/user_provider.dart';
import 'package:photometic/repositories/user_repositories.dart';
import 'package:provider/provider.dart';

class ProfileSettingTab extends StatelessWidget {
  const ProfileSettingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepositories = UserRepositories();

    void changeProfile() async {
      XFile? imageFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        var image = File(imageFile.path);
        var res = await userRepositories.changeProfile(image);
        Fluttertoast.showToast(msg: res["message"]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("계정 설정"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ChangeNotifierProvider(
        create: (context) => UserProvider(userRepositories: userRepositories),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<UserProvider>(
                    builder: (context, value, child) {
                      var profile = value.userCache["userProfile"];
                      return CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.black,
                        backgroundImage: (profile == null)
                            ? const AssetImage(
                                    "assets/images/basic_profile.png")
                                as ImageProvider
                            : NetworkImage(profile),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () => changeProfile(),
                    child: const Text("프로필 사진 변경"),
                  ),
                  Divider(
                    color: Colors.red[200],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text("이름"),
                Text("아이디"),
                Text("비밀번호"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

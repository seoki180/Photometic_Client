import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photometic/providers/user_provider.dart';
import 'package:photometic/repositories/user_%20repositories.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  File? _photo;
  bool isPicked = false;

  final userRepositories = UserRepositories();
  get userProvider => UserProvider(userRepositories: userRepositories);

  void getAlbum() async {
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _photo = File(imageFile.path);
        isPicked = true;
        sendPhoto();
      });
    }
  }

  void sendPhoto() {
    userRepositories.uploadPhoto(photo: _photo!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              flex: 25,
              child: TopBar(),
            ),
            Flexible(
              flex: 120,
              child: MainContents(
                isPicked: isPicked,
                photo: _photo,
              ),
            ),
            Flexible(
              flex: 20,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: () {
                        getAlbum();
                      },
                      backgroundColor: Colors.red[200],
                      child: const Icon(Icons.publish),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MainContents extends StatelessWidget {
  const MainContents({
    super.key,
    required this.isPicked,
    required File? photo,
  }) : _photo = photo;

  final bool isPicked;
  final File? _photo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
            padding: EdgeInsets.only(top: 100), child: Text("Home Tab")),
        Container(
          child: isPicked
              ? Image.file(_photo!)
              : const SizedBox(
                  width: 100,
                ),
        ),
      ],
    );
  }
}

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  void changeUserProfile() async {
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      var image = File(imageFile.path);
      UserRepositories().changeProfile(image);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Flexible(
              flex: 7,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Consumer<UserProvider>(
                      builder: (context, value, child) {
                        var profile = value.userCache["userProfile"];
                        return GestureDetector(
                          onTap: () => {changeUserProfile(), setState(() {})},
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                            backgroundImage: profile != null
                                ? NetworkImage(profile)
                                : const AssetImage(
                                        "assets/images/basic_profile.png")
                                    as ImageProvider,
                          ),
                        );
                      },
                    ),
                  ),
                  Consumer<UserProvider>(
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          Text(
                            "${value.userCache["userName"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                children: const [
                  Text("정렬 기준"),
                  Text("숨김 라이브러리"),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
            width: 400, child: Divider(color: Colors.red, thickness: 0.2))
      ],
    );
  }
}

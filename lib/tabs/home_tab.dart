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
  var userRepositories = UserRepositories();

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

  void getAllPhotos(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getPhotoUrl();
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
                    ElevatedButton(
                        onPressed: () {
                          getAllPhotos(context);
                        },
                        child: const Text("ok"))
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
  var profilePhoto = '';

  void getProfilePhoto(context) {
    var data = Provider.of<UserProvider>(context, listen: false);
    if (data.userCache["profilePhoto"] != '') {
      profilePhoto = data.userCache["profilePhoto"];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    getProfilePhoto(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 150, 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black,
                    backgroundImage: profilePhoto.isEmpty
                        ? const AssetImage("assets/images/basic_profile.png")
                            as ImageProvider
                        : NetworkImage(profilePhoto),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<UserProvider>(
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
                  ),
                ],
              ),
            ),
            Column(
              children: const [
                Text("정렬 기준"),
                Text("숨김 라이브러리"),
              ],
            ),
          ],
        ),
        const SizedBox(
            width: 400, child: Divider(color: Colors.red, thickness: 0.2))
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photometic/providers/photo_provider.dart';
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
    userRepositories.uploadPhoto(_photo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 20,
              child: TopBar(),
            ),
            Expanded(
              flex: 100,
              child: MainContents(
                isPicked: isPicked,
                photo: _photo,
              ),
            ),
            Row(
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
    var userRepositories = UserRepositories();
    var photoProvider = PhotoProvider(userRepositories: userRepositories);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
            future: photoProvider.getPhotoInfo(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data == "no") {
                return const Text("아직 사진이 없습니다!");
              } else {
                print(snapshot.data);
                return Expanded(
                  child: GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      // mainAxisSpacing: 8, // Spacing between rows
                      // crossAxisSpacing: 8, // Spacing between columns
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Image(
                        image: NetworkImage(snapshot.data[index]),
                      );
                    },
                  ),
                );
              }
            })
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
  Widget build(BuildContext context) {
    final userRepositories = UserRepositories();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(userRepositories: userRepositories),
          child: Row(
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
                          return CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black,
                            backgroundImage: (profile == null)
                                ? const AssetImage(
                                        "assets/images/basic_profile.png")
                                    as ImageProvider
                                : NetworkImage(profile),
                          );
                        },
                      ),
                    ),
                    Column(
                      children: [
                        Consumer<UserProvider>(
                          builder: (context, value, child) {
                            return Text(
                              "${value.userCache["userName"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          },
                        ),
                      ],
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
        ),
        const SizedBox(
          width: 500,
          child: Divider(
            color: Colors.red,
            thickness: 0.2,
          ),
        )
      ],
    );
  }
}

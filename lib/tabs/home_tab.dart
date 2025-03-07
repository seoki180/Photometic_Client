import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photometic/providers/photo_provider.dart';
import 'package:photometic/providers/user_provider.dart';
import 'package:photometic/repositories/user_repositories.dart';
import 'package:photometic/tabs/detail_tab.dart';

import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  File? _photo;

  final userRepositories = UserRepositories();

  void getAlbum() async {
    XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      final bytes = await imageFile.readAsBytes();
      final exifData = await readExifFromBytes(bytes);
      IfdTag? photoDate;
      final uploadDate = DateTime.now();

      if (exifData.containsKey("EXIF DateTimeOriginal")) {
        photoDate = exifData["EXIF DateTimeOriginal"];
      }
      setState(() {
        _photo = File(imageFile.path);
      });
      await userRepositories
          .uploadPhoto(
        _photo,
        photoDate,
        uploadDate,
      )
          .then((value) {
        if (value["isSuccess"]) {
          Fluttertoast.showToast(msg: value["message"].toString());
        } else {
          Fluttertoast.showToast(msg: value["message"].toString());
        }
      });
    } else {
      Fluttertoast.showToast(msg: "no image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Photometic",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 2,
                    )
                  ],
                )),
            const Expanded(
              flex: 100,
              child: MainContents(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () {
          getAlbum();
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.publish),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MainContents extends StatefulWidget {
  const MainContents({
    super.key,
  });

  @override
  State<MainContents> createState() => _MainContentsState();
}

class _MainContentsState extends State<MainContents> {
  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var userRepositories = UserRepositories();
    var photoProvider = PhotoProvider(userRepositories: userRepositories);

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: photoProvider.getPhotoInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns
                      childAspectRatio: 2 / 5, //ratio of photos
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final url = snapshot.data[index]["photoUrl"];
                      final imageId =
                          snapshot.data[index]["user_id"].toString();
                      final idx = snapshot.data[index]["idx"].toString();

                      return GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailTab(
                                imageUrl: url,
                                imageId: imageId,
                                imageIdx: idx,
                              ),
                            ),
                          ),
                        },
                        child: Hero(
                          tag: idx,
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
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
        Divider(
          color: Theme.of(context).primaryColor,
          thickness: 1,
        )
      ],
    );
  }
}

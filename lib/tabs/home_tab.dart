import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photometic/providers/photos_provider.dart';
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

  @override
  void initState() {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // final photosProvider = Provider.of<PhotosProvider>(context, listen: false);
    // userProvider.getProfile();
    // photosProvider.getPhotos();
    super.initState();
  }

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

  void checkPhotos(BuildContext context) async {
    var data = context.read<PhotosProvider>().getPhotos();
  }

  void sendPhoto() {
    var userRepositories = UserRepositories();
    userRepositories.uploadPhoto(photo: _photo!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 120,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Consumer<UserProvider>(
                        builder: (context, value, child) {
                          return Text("환영합니다 ${value.userCache["name"]}");
                        },
                      ),
                    ),
                    const PhotoView(),
                    Container(
                      child: isPicked
                          ? Image.file(_photo!)
                          : const SizedBox(
                              width: 100,
                            ),
                    ),
                  ],
                ),
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
                    const SizedBox(
                      width: 100,
                    ),
                    FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: () {
                        checkPhotos(context);
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

class PhotoView extends StatelessWidget {
  const PhotoView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset("assets/images/img1.gif"),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset("assets/images/img1.gif"),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset("assets/images/img1.gif"),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset("assets/images/img1.gif"),
          ),
        ],
      ),
    );
  }
}


// FloatingActionButton(
//                 onPressed: () {},
//                 backgroundColor: Colors.red[200],
//                 child: const Icon(Icons.publish),
//               ),

// Consumer<UserProvider>(
//                   builder: (context, value, child) {
//                     return Text("환영합니다 ${value.userCache["name"]}");
//                   },
//                 ),
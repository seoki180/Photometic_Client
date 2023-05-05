import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photometic/repositories/user_%20repositories.dart';

class DetailTab extends StatelessWidget {
  final String imageUrl, imageId, imageIdx;

  const DetailTab({
    required this.imageUrl,
    required this.imageId,
    required this.imageIdx,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userRepositories = UserRepositories();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                Hero(
                  tag: imageIdx,
                  child: Image.network(imageUrl),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await userRepositories.deletePhoto(imageIdx);
          Fluttertoast.showToast(msg: res.toString());
          Navigator.pop(context);
        },
        child: const Icon(Icons.delete),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

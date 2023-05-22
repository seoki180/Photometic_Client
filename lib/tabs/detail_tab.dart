import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photometic/repositories/user_repositories.dart';

class DetailTab extends StatefulWidget {
  final String imageUrl, imageId, imageIdx;

  const DetailTab({
    required this.imageUrl,
    required this.imageId,
    required this.imageIdx,
    super.key,
  });

  @override
  State<DetailTab> createState() => _DetailTabState();
}

class _DetailTabState extends State<DetailTab> {
  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userRepositories = UserRepositories();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                Hero(
                  tag: widget.imageIdx,
                  child: Image.network(widget.imageUrl),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          final res = await userRepositories.deletePhoto(widget.imageIdx);
          Fluttertoast.showToast(msg: res["message"]);
          _refresh();
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.delete,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

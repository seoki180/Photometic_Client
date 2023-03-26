// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:photometic/models/photo_model.dart';

// class PhotoTab extends StatefulWidget {
//   const PhotoTab({super.key});

//   @override
//   State<PhotoTab> createState() => _PhotoTabState();
// }

// final photoModel = PhotoModel();

// class _PhotoTabState extends State<PhotoTab>
//     with SingleTickerProviderStateMixin {
//   final storage = const FlutterSecureStorage();

//   File? _pickedPhoto;
//   bool isPicked = false;

//   void getAlbum() async {
//     var picker = ImagePicker();
//     var image = await picker.pickImage(source: ImageSource.gallery);
//     // photoModel.setPhoto(image);
//     if (image != null) {
//       photoModel.addPhoto(File(image.path));
//       setState(() {
//         _pickedPhoto = File(image.path);
//         isPicked = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text("사진 탭"),
//             Container(
//               margin: const EdgeInsets.only(top: 50),
//               height: 50,
//               width: 100,
//               child: ElevatedButton(
//                 onPressed: () {
//                   getAlbum();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                 ),
//                 child: const Text("사진올리기"),
//               ),
//             ),
//             Container(
//               child: isPicked
//                   ? Image.file(_pickedPhoto!)
//                   : const SizedBox(
//                       width: 100,
//                     ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 print("${photoModel.getPhoto()}");
//               },
//               child: const Text("사진보기"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

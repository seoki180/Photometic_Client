import 'dart:io';

class PhotoModel {
  List<File> photos = [];
  addPhoto(photo) {
    photos.add(photo);
  }

  getPhoto() {
    return photos;
  }
}

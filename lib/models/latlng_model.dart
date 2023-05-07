import 'package:exif/exif.dart';
import 'package:flutter/material.dart';

class LatLngModel extends ChangeNotifier {
  double Lat = 0;
  double Lng = 0;
  IfdTag lat;
  IfdTag lng;
  Map<String, double> LatLng = {
    "lat": 0.0,
    'lng': 0.0,
  };

  LatLngModel({
    required this.lat,
    required this.lng,
  }) {
    print(lat);
    print(lng);
    Lat = changeToDouble(lat.values.toList());
    Lng = changeToDouble(lng.values.toList());
    LatLng["lat"] = Lat;
    LatLng["lng"] = Lng;
  }

  double changeToDouble(lat) {
    List latlng = [];
    for (var i = 0; i < lat.length; i++) {
      latlng.add(lat[i].toDouble());
    }
    double latitudeDegree = latlng[0] + latlng[1] / 60 + latlng[2] / 3600;
    double latitudeSign = latlng[0] < 0 ? -1 : 1; // 위도(latitude)의 부호 계산
    double latitudeDecimal = latitudeDegree * latitudeSign;
    return latitudeDecimal;
  }
}

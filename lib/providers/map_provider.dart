import 'package:geolocator/geolocator.dart';

class MapProvider {
  Future<String> checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return "위치 서비스를 활성화 해주세요";
    } else {
      var checkPermission = await Geolocator.checkPermission();
      if (checkPermission == LocationPermission.denied) {
        checkPermission = await Geolocator.requestPermission();
        if (checkPermission == LocationPermission.denied) {
          return "위치 권한을 허가 해주세요";
        }
      }
    }
    return "위치 권한이 허가 되었습니다";
  }
}

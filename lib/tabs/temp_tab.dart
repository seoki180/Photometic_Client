import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photometic/providers/map_provider.dart';

class TempTab extends StatelessWidget {
  const TempTab({super.key});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    var mapProvider = MapProvider();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: const Text("Photometic"),
      ),
      body: Center(
        child: Column(
          children: const [
            Expanded(
              flex: 2,
              child: GoogleMap(
                initialCameraPosition: _kGooglePlex,
                myLocationEnabled: true,
              ),
            ),
            // Expanded(
            //   flex: 2,
            //   child: FutureBuilder(
            //     future: mapProvider.checkPermission(),
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) {
            //         return const CircularProgressIndicator();
            //       } else if (snapshot.data == "위치 권한이 허가 되었습니다") {
            //         return const GoogleMap(
            //           initialCameraPosition: CameraPosition(
            //             target: startLng,
            //             zoom: 16,
            //           ),
            //           myLocationEnabled: true,
            //         );
            //       } else {
            //         return Text(snapshot.data.toString());
            //       }
            //     },
            //   ),
            // ),
            Expanded(
              child: Text("hello"),
            ),
          ],
        ),
      ),
    );
  }
}

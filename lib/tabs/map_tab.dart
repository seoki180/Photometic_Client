import 'package:flutter/material.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              color: Colors.red,
            ),
            Container(
              height: 150,
              color: Colors.amberAccent,
            ),
            Container(
              height: 150,
              color: Colors.red,
            ),
            Container(
              height: 150,
              color: Colors.amberAccent,
            ),
            Container(
              height: 150,
              color: Colors.red,
            ),
            Container(
              height: 150,
              color: Colors.amberAccent,
            ),
          ],
        ),
      ),
    );
  }
}

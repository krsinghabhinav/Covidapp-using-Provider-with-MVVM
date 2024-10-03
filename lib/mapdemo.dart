import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Without API Key'),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Container(
      height: 400,
      child: FlutterMap(
        options: const MapOptions(
            initialCenter: LatLng(
              28.541880445531753,
              77.33340270330501,
            ),
            initialZoom: 11,
            maxZoom: 50,
            minZoom: 10,
            initialRotation: 30.5,
            interactionOptions: InteractionOptions(flags: InteractiveFlag.all)),
        children: [
          openStreetMapTileLater,
          MarkerLayer(markers: [
            Marker(
              point: LatLng(
                28.541880445531753,
                77.33340270330501,
              ),
              width: 80,
              height: 80,
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.location_pin,
                color: Colors.red,
              ),
            )
          ])
        ],
      ),
    );
  }
}

TileLayer get openStreetMapTileLater => TileLayer(
      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );

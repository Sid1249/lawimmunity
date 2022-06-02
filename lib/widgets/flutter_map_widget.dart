import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lawimmunity/screens/location_page/location_provider.dart';
import 'package:provider/provider.dart';

class FlutterMapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  late MapController mapController;



  FlutterMapWidget(
      {Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: Provider.of<LocationProvider>(context, listen: true).mapController,
      options: MapOptions(
          center: LatLng(latitude, longitude),
          zoom: 15.0,
          maxZoom: 19,
        onMapCreated: (c){
          Provider.of<LocationProvider>(context, listen: true).mapController = c;
        }
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return Text("© OpenStreetMap contributors");
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(latitude, longitude),
              builder: (ctx) => Container(
                child: Icon(
                  Icons.my_location,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

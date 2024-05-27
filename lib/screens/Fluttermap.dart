import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:nurseries/screens/user/User_Hospitaildetailes.dart';
class Fluttermap extends StatelessWidget {
   double lat;
    double log;
   Fluttermap({super.key, required this.lat, required this.log});


  @override
  Widget build(BuildContext context) {






    return Scaffold(

      body: Container(
        child: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(  30.136311  , 31.343679),
            initialZoom: 15,
            minZoom: 0,
            maxZoom: 19,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName:
              'net.tlserver6y.flutter_map_location_marker.example',
              maxZoom: 19,
            ),
            CurrentLocationLayer(),
            MarkerLayer(markers: [

                Marker(
                  point: LatLng(lat , log),
                  child: Icon(Icons.location_on_rounded, color: Colors.red),
                ),
            ])
          ],
        ),
      ));


  }
}

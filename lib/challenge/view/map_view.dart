


import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:thrive/global/services/network_monitor.dart';

class MapView extends StatefulWidget {
  static String id= "/MapView";
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}





class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
     final network = Provider.of<NetworkMonitor>(context);

    return  Scaffold(
appBar: AppBar(),
      body: network.isConnectedToInternet?
     
      Center(child: Text("Failed to connect to internet"),):
       Stack(
        children: [
          Expanded(child: 
          FlutterMap(
            children: [
               TileLayer(
                          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        ),
            ]
            )
          )
        ],
      )
      ,
    );
  }
}
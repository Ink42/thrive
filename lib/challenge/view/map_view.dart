


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:thrive/challenge/location_controller.dart';
import 'package:thrive/challenge/view_model/route_view_model.dart';
import 'package:thrive/global/services/network_monitor.dart';

class MapView extends StatefulWidget {
  static String id= "/MapView";
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}





class _MapViewState extends State<MapView> {
    bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _initializeLocation();
      final networkMonitor = Provider.of<NetworkMonitor>(context, listen: false);
  networkMonitor.check();
   
    //  location.getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
     final network = Provider.of<NetworkMonitor>(context);
     final location = Provider.of<LocationController>(context);
    //  location.getUserLocation();
    //  location.enableService();


     log('message location ${location.currentPosition}');

    final RouteViewModel _viewModel = Provider.of<RouteViewModel>(context);

    return  Scaffold(
appBar: PreferredSize(
  preferredSize: Size(double.infinity, size.width * 0.24), 
  child: Container(
    padding: EdgeInsets.only(top: 30,left: 20,right: 20),
    // color: Colors.amber,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_rounded)),
        Text("Tracking activities",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        IconButton(onPressed: (){}, icon: Icon(Icons.calendar_today_outlined)),
      ],
    ),
  )),
      body: network.isConnectedToInternet?
     
      
       Stack(
        children: [
          Expanded(child: 
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(-26.2297144,27.893659),
              initialZoom: 18,
              minZoom: 12,
              onTap: (tapPosition, point) => _onMapTap(point)
            ),
            children: [
               TileLayer(
                          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        ),
              MarkerLayer(markers: [
                const Marker(point: LatLng(-26.2297144,27.893659),
                  child: Icon(
                                Icons.radio_button_checked,
                                color: Colors.amber,
                                size: 30.0,
                              ),
                 ),
                  if (_viewModel.destination != null)
                              Marker(
                                point: _viewModel.destination!,
                                child: const Icon(
                                  Icons.sports_score,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                              ),
              ]),
               if (_viewModel.routeModel?.routePoints != null)
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: _viewModel.routeModel!.routePoints,
                                strokeWidth: 4.0,
                                color: Colors.amber,
                              ),
                            ],
                          ),
            ],
            
            )
            
          ),
          BottomMapOptions(size: size)
        ],
      ):
      Center(child: Text("Failed to connect to internet"),)
      ,
    );
  }


    Future<void> _initializeLocation() async {
    try {
        final  location = Provider.of<LocationController>(context);
     location.enableService();
      final RouteViewModel _viewModel = Provider.of<RouteViewModel>(context, listen: false);

      LatLng? currentLocation = await _viewModel.getCurrentLocation();
      _viewModel.startLocation =  currentLocation;

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
setState(() {
  _isLoading = false;
});
_showError("Failed to initialize location: $e");}
  }

  void _onMapTap(LatLng point) async {
     try {
      final RouteViewModel _viewModel = Provider.of<RouteViewModel>(context, listen: false);
            log("message Destination not set");

      _viewModel.destination = point;
      log("message Destination point ${point}");

      log("message Destination ${_viewModel.destination}");
      await _viewModel.fetchRoute();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError(e.toString());
    }
  }

void _showError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.redAccent,
    ),
  );
}
}

class BottomMapOptions extends StatefulWidget {
  const BottomMapOptions({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<BottomMapOptions> createState() => _BottomMapOptionsState();
}

class _BottomMapOptionsState extends State<BottomMapOptions> with SingleTickerProviderStateMixin {
  bool showMoreOption = false;

  void changeMenu() {
    setState(() {
      showMoreOption = !showMoreOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () => changeMenu(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300), // Duration of the animation
          curve: Curves.easeInOut, // Animation curve
          margin: showMoreOption ? EdgeInsets.all(10) : EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: showMoreOption
              ? MediaQuery.of(context).size.height * 0.7
              : MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
            if (!showMoreOption)  Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.10,
                          width: MediaQuery.of(context).size.width * 0.10,
                          child: Image.asset("assets/icons/walk.gif"),
                        ),
                        const Text("Steps 2923", style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.turn_sharp_right_outlined),
                        Text("30.1 km away", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.trending_up_rounded),
                        Text("4/6", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
            ),
              // Animated transition for expanded content
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Save current location as point?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                crossFadeState: showMoreOption
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

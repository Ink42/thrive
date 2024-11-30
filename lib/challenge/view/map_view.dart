


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:thrive/challenge/location_controller.dart';
import 'package:thrive/challenge/view_model/route_view_model.dart';
import 'package:thrive/const/constant.dart';
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
               urlTemplate: map_types["openstreetmap"]
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
    int selected_map = 3;
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () => showMoreOption? (){}:changeMenu(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300), 
          curve: Curves.easeInOut,
          margin: showMoreOption ? EdgeInsets.all(10) : EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: showMoreOption
              ? MediaQuery.of(context).size.height * 0.8
              : MediaQuery.of(context).size.width * 0.15,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            if (!showMoreOption)  Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    Icon(Icons.more_vert_rounded)
                  ],
                ),
            ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild:  Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => changeMenu(),
                             icon: Icon(Icons.keyboard_arrow_down_rounded))
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Save current location as point?",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            IconButton(onPressed: (){}, icon: Icon(Icons.location_searching_rounded))
                          ],
                        ),
                           Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Share your current location",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            IconButton(onPressed: (){}, icon: Icon(Icons.share_location_rounded))
                          ],
                        ),
                      SizedBox(height: 20,),
                      
                            Row(
                              children: [
                                Text(
                                  "Select a map",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                      SizedBox(height: 20,),
                      Container(
                        height: 110,
                        // color: Colors.grey,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (_,index){
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                        // height: /1,
                        width: 120,
                        decoration: BoxDecoration(
                              // color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20)
                        
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                                      width: 120,
                              
                                 decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(image: 
                                NetworkImage("url")
                                )
                                                      
                                                      ),
                              ),
                            ),
                            SizedBox(height: 9,),
                            Container(
                               decoration: BoxDecoration(
                               color: selected_map ==index? Colors.amber: Colors.transparent,

                                borderRadius: BorderRadius.circular(20)
                                                      
                                                      ),
                              height: 5,
                              width: 48,
                            )
                          ],
                        ),
                            );
                          }
                          ),
                      ),
                      SizedBox(height: 30,),

                        Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Row(children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text("Duration"),
                                  Text("20:16",
                                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                                  ),
                                ],),
                              ),
                            ),
                            SizedBox(width: 10,),                             Expanded(
                               child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text("Distance"),
                                  Text("1.8 km",
                                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                                  ),
                                ],),
                                                           ),
                             )
                          ],),
                          
                         Row(children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text("Steps"),
                                  Text("2876",
                                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                                  ),
                                ],),
                              ),
                            ),
                            SizedBox(width: 10,),                             Expanded(
                               child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text("_"),
                                  Text("__ : __",
                                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                                  ),
                                ],),
                                                           ),
                             )
                          ],),
                        ],),
                          SizedBox(height: 30,),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: MaterialButton( 
                            // minWidth: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            color: Colors.amber,
                            onPressed: (){},
                            child: Text("Save",
                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextButton(onPressed: (){}, child: Text("Cancel")))

                        ],
                      ),
                        
                      ],
                    ),
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

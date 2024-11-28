import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class RouteViewModel extends ChangeNotifier {
  LatLng? startLocation;
  LatLng? destination;
  RouteModel? routeModel;
  bool _isFetching = false;

  bool get isFetching => _isFetching;

  Future<LatLng?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception("Location services are disabled.");

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission is denied.");
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));
    return LatLng(position.latitude, position.longitude);
  }

Future<void> fetchRoute() async {
  startLocation = await getCurrentLocation();

  if (startLocation == null || destination == null) {
    throw Exception("Start or destination is not set: $startLocation || $destination");
  }

  log("message fetchRoute working");
  _isFetching = true;
  notifyListeners();

  final url =
      'https://router.project-osrm.org/route/v1/foot/${startLocation!.longitude},${startLocation!.latitude};${destination!.longitude},${destination!.latitude}?overview=full&geometries=geojson';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coordinates = data['routes'][0]['geometry']['coordinates'];

      final List<LatLng> routePoints = coordinates
          .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
          .toList();

      final double distance = data['routes'][0]['distance'] / 1000;

      routeModel = RouteModel(routePoints: routePoints, distance: distance);

      _isFetching = false;
      notifyListeners();
    } else {
      throw Exception("Failed to fetch route: ${response.statusCode}");
    }
  } catch (e) {
    _isFetching = false;
    notifyListeners();
    rethrow;
  }
}

}

class RouteModel {
  final List<LatLng> routePoints;
  final double distance;

  RouteModel({
    required this.routePoints,
    required this.distance,
  });
}

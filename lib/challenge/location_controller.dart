import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
// import 'package:mobile_project_fitquest/core/core_services/location_services.dart';

class LocationController extends ChangeNotifier {
  final LocationService _locationService = LocationService();

  bool _isServiceEnabled = false;
  late LocationPermission _locationPermission;
  late Position _currentPosition = Position(
    longitude: 0, 
    latitude: 0, 
    timestamp: DateTime.now(), 
    accuracy: 0, 
    altitude: 0, 
    altitudeAccuracy: 0,
    heading: 0, 
    headingAccuracy: 0,
    speed: 0, 
    speedAccuracy: 0
  );

  bool get isServiceEnabled => _isServiceEnabled;
  Position get currentPosition => _currentPosition;

  Future<Position?> get getUsersLastKnownPosition => _locationService.getLastKnownPosition();


Future<bool> enableService() async {
  _isServiceEnabled = await _locationService.isLocationServiceEnabled();
  if (!_isServiceEnabled) {
    log("Location services are disabled.");
    return false;
  }

  _locationPermission = await _locationService.requestPermission();
  if (_locationPermission == LocationPermission.denied) {
    log("LocationPermission denied.");
    return false;
  }

  if (_locationPermission == LocationPermission.deniedForever) {
    log("LocationPermission denied forever. Please enable manually in settings.");
    await Geolocator.openLocationSettings();
    return false;
  }

  log("Location services enabled, permission granted: $_locationPermission");
  return true;
}


  
  Future<void> getUserLocationContinuously() async {
    bool isEnabled = await enableService();
    if (!isEnabled) return;

    
    _locationService.getLocationStream().listen((Position? newPosition) {
      if (newPosition != null) {
        _currentPosition = newPosition;
        notifyListeners(); 
      } else {
        log("Failed to get current position");
      }
    });
  }


Future<Position> getUserLocation() async {
  try {
    bool isEnabled = await enableService();
    if (!isEnabled) {
      log("Location service is not enabled.");
      return _currentPosition; 
    }

    _currentPosition = await _locationService.getCurrentPosition();
    notifyListeners();
    log("Current Position: Latitude ${_currentPosition.latitude}, Longitude ${_currentPosition.longitude}");
    return _currentPosition;
  } catch (e) {
    log("Error fetching location: $e");
    return _currentPosition; 
  }
}


  double getDistance(LatLng currentLocation, LatLng targetLocation) {
    return _locationService.getDistance(currentLocation, targetLocation);
  }
}



class LocationService {
  Future<bool> isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
  }

 
  Future<LocationPermission> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  
  Future<Position?> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }


  Stream<Position> getLocationStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 90,
    );
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

 
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }


  double getDistance(LatLng currentLocation, LatLng targetLocation) {
    return Geolocator.distanceBetween(
      currentLocation.latitude, currentLocation.longitude,
      targetLocation.latitude, targetLocation.longitude,
    );
  }
}

// with this

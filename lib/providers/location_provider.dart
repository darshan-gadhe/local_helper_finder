import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider with ChangeNotifier {
  String _currentLocation = "Select Location";

  String get currentLocation => _currentLocation;

  LocationProvider() {
    loadLocation();
  }

  Future<void> loadLocation() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLocation = prefs.getString('userLocation') ?? "New York, USA";
    notifyListeners();
  }

  Future<void> changeLocation(String newLocation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userLocation', newLocation);
    _currentLocation = newLocation;
    notifyListeners();
  }
}
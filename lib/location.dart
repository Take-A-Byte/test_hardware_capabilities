import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationAccessExample extends StatefulWidget {
  const LocationAccessExample({Key? key}) : super(key: key);

  @override
  _LocationAccessExampleState createState() => _LocationAccessExampleState();
}

class _LocationAccessExampleState extends State<LocationAccessExample> {
  Position? _currentPosition;
  String _locationStatus = 'Waiting to get location...';

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationStatus = 'Location services are disabled.';
      });
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationStatus = 'Location permissions are denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationStatus = 'Location permissions are permanently denied.';
      });
      return;
    }

    // If permissions are granted, get the current location
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _locationStatus = 'Location retrieved successfully';
      });
    } catch (e) {
      setState(() {
        _locationStatus = 'Failed to get location: ${e.toString()}';
      });
    }
  }

  Future<void> _openLocationSettings() async {
    // Open device settings for the app
    await openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Access'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _locationStatus,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            if (_currentPosition != null) ...[
              const SizedBox(height: 20),
              Text(
                'Latitude: ${_currentPosition!.latitude}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Longitude: ${_currentPosition!.longitude}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text('Get Location'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _openLocationSettings,
              child: const Text('Open App Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

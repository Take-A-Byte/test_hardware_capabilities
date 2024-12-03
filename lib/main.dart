import 'package:flutter/material.dart';
import 'package:test_hardware_capabilities/location.dart';
import 'package:test_hardware_capabilities/camera.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExampleSelector(),
    );
  }
}

class ExampleSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Example'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Location Access Example'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LocationAccessExample()),
              );
            },
          ),
          ListTile(
            title: Text('Image Picker Example'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImagePickerExample()),
              );
            },
          ),
          // Add more examples here
        ],
      ),
    );
  }
}

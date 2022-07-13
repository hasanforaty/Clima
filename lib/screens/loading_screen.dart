import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() {
    Location.getCurrentLocation().catchError((error) {
      print("error : $error");
    }).then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }
}

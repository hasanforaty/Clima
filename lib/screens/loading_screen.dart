import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  late double latitude, longitude;
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    try {
      var location = await Location.getCurrentLocation();
      widget.latitude = location.latitude;
      widget.longitude = location.longitude;
      var networkHelper = NetworkHelper(
          "https://api.openweathermap.org/data/2.5/weather?lat=${widget.latitude}&lon=${widget.longitude}&appid=$kApiKey");
      var data = await networkHelper.getData();
      print(data);
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold();
  }

  @override
  void initState() {
    super.initState();
  }
}

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation(BuildContext context) async {
    try {
      var data = await WeatherModel().getCurrentLocationWeather();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(
          locationWeather: data,
        );
      }));
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getLocation(context);
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/loading_gray.json"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

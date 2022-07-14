import 'package:clima/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Location {
  double latitude, longitude;

  Location(this.latitude, this.longitude);
  static Future<Position> _getLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return Future.error("location services are disables");
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
  }

  static Future<Location> getCurrentLocation() async {
    var result = await _getLocation();
    return Location(result.latitude, result.longitude);
  }

  static Future<Location> getLocationByName({required String name}) async {
    var url = Uri.parse("$kGetLocationUrl?imit=5&q=$name&appid=$kApiKey");
    var responce = await http.get(url);
    if (responce.statusCode != 200) {
      return Future.error(Exception(responce.body));
    }
    var jsonObject = jsonDecode(responce.body);
    return Location(jsonObject[0]["lat"], jsonObject[0]["lon"]);
  }

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude}';
  }
}

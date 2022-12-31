import 'package:clima/services/location.dart';
import 'package:clima/utilities/constants.dart';

import 'networking.dart';

class WeatherModel {
  Future getCurrentLocationWeather() async {
    var location = await Location.getCurrentLocation();
    return await _getLocation(location);
  }

  Future getLocationWeatherByName(String name) async {
    var location = await Location.getLocationByName(name: name);
    return await _getLocation(location);
  }

  Future<dynamic> _getLocation(Location location) async {
    var networkHelper = NetworkHelper(
        "$kGetWeatherUrl?units=metric&lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey");
    var result = await networkHelper.getData();
    print(result);
    return result;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

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
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}

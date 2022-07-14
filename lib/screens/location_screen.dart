import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/services/location.dart';
import 'package:lottie/lottie.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({required this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;
  final weather = WeatherModel();
  void updateUI(dynamic weatherData) {
    setState(() {
      this.temperature = (weatherData["main"]["temp"] as double).toInt();
      var condition = weatherData["weather"][0]["id"] as int;
      this.cityName = weatherData["name"];
      this.weatherMessage = weather.getMessage(temperature);
      weatherIcon = weather.getWeatherIcon(condition);
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      updateUI(await weather.getCurrentLocationWeather());
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }),
                      );
                      if (result == null) return;
                      showLoadingScreen();
                      try {
                        var updateResult = await weather
                            .getLocationWeatherByName(result as String);
                        updateUI(updateResult);
                      } on Exception catch (e) {
                        //TODO
                        print(e);
                      } finally {
                        Navigator.pop(context);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLoadingScreen() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Please Waite"),
            content: Lottie.asset("assets/loading_gray.json"),
          );
        });
  }
}

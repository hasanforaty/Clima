import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestPlace extends StatelessWidget {
  const TestPlace({Key key}) : super(key: key);

  void getTestDone() async {
    Uri uri = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=570a5be1fbee8e473bb6ee1e50222f40#");
    var httpResult = await http.get(uri);
    var json = httpResult.body;
    var jsonObject = jsonDecode(json);

    var result = jsonObject["weather"][0]["main"];
    //result = "Clouds"
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    getTestDone();
    return Scaffold();
  }
}

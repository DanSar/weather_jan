import 'package:flutter/material.dart';
import 'package:weather_jan/constants/size_colors.dart';
import 'package:weather_jan/screens/home/home.dart';

import '../api/weather_api.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  void getLocationData() async {
    try {
      var weatherInfo = await WeatherApi().fetchWeatherCity();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyHomePage(locationWeather: weatherInfo);
      }));
    } catch (e) {
      print('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: colorProgressIndicator,
        ),
      ),
    );
  }
}

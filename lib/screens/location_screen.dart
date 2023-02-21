import 'package:flutter/material.dart';
import 'package:weather_jan/const/weather_api.dart';
import 'package:weather_jan/screens/home.dart';

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
          color: Colors.white,
        ),
      ),
    );
  }
}

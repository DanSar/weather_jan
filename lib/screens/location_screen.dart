import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weather_jan/constants/size_colors.dart';
import 'package:weather_jan/screens/home/home.dart';
import '../api/weather_api.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Future<void> getLocationData() async {
    try {
      var weatherInfo = await WeatherApi().fetchWeatherCity();

      // Проверяем, не уничтожен ли виджет
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(locationWeather: weatherInfo)),
      );
    } catch (e) {
      log('Ошибка получения данных о погоде: $e');
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

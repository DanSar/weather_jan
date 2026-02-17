import 'package:flutter/material.dart';
import 'package:weather_jan/constants/size_colors.dart';
import 'package:weather_jan/screens/air/screen_index_air.dart';

import '../../api/air_api.dart';

class LocationAir extends StatefulWidget {
  const LocationAir({super.key});

  @override
  State<LocationAir> createState() => _LocationAirState();
}

class _LocationAirState extends State<LocationAir> {
  void getLocationAir() async {
    try {
      var airInfo = await AirApi().fetchAirPollution();

      // Проверяем, не уничтожен ли виджет
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenIndexAir(locationAir: airInfo),
        ),
      );
    } catch (error) {
      debugPrint('Ошибка получения данных о качестве воздуха: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationAir();
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

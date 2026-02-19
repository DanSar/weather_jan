import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_jan/constants/size_colors.dart';

class DataSource extends StatelessWidget {
  const DataSource({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'Данные предоставлены',
        style: TextStyle(color: Colors.white70),
      ),
      FaIcon(
        FontAwesomeIcons.cloudSun,
        color: colorText,
      ),
      Text(
        'OpenWeatherMap',
        style: TextStyle(color: colorText, fontWeight: FontWeight.bold),
      ),
    ]);
  }
}

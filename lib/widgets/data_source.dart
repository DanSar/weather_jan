import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DataSource extends StatelessWidget {
  const DataSource({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'Данные предоставлены',
        style: TextStyle(color: Colors.white70),
      ),
      FaIcon(
        FontAwesomeIcons.cloudSun,
        color: Colors.white,
      ),
      Text(
        'OpenWeatherMap',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ]);
  }
}

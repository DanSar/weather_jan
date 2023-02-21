import 'package:flutter/material.dart';

import '../const/formatted.dart';

Widget hourlyCard(AsyncSnapshot snapshot, int index) {
  final forecastList = snapshot.data?.list;
  var time = '';
  DateTime date =
      DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt * 1000);
  final fullDate = Util.getHourMinute(date);
  // fullDate.split(',')[0]
  time = fullDate;
  final temp = forecastList[index].main.temp.toStringAsFixed(0);
  final icon = forecastList[index].getIconUrl();
  final deg = forecastList[index].wind.deg;
  final speedWind = forecastList[index].wind.speed.toStringAsFixed(1);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(
      children: [
        Text(
          time,
          style: TextStyle(color: Colors.white70),
        ),
        Text(
          '$temp°C',
          style: TextStyle(color: Colors.white),
        ),
        Image.network(icon),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (deg > 45 && deg <= 135) ...[
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ] else if (deg > 135 && deg <= 225) ...[
              Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
            ] else if (deg > 225 && deg <= 315) ...[
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ] else ...[
              Icon(
                Icons.arrow_upward,
                color: Colors.white,
              )
            ],
            Text(
              '$speedWind км/ч',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    ),
  );
}

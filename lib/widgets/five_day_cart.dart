import 'package:flutter/material.dart';

import '../const/formatted.dart';

Widget fiveDayCard(AsyncSnapshot snapshot, int index) {
  var forecastList = snapshot.data?.list;
  var dayOfWeekCard = '';
  DateTime date =
      DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt * 1000);
  var timeDate = Util.getHourMinute(date);
  var monthDate = Util.getMonthDate(date),
      // fullDate.split(',')[0]
      dayCard = monthDate; // Tue
  var tempMinCard = forecastList[index].main.temp_min.toStringAsFixed(0);
  // var tempMin = forecastList[0].main?.temp_min?.toStringAsFixed(0);
  var tempMaxCard = forecastList[index].main.temp_max.toStringAsFixed(0);
  var icon = forecastList[index].getIconUrl();
  var speedWind = forecastList[index].wind.speed.toStringAsFixed(1);
  var deg = forecastList[index].wind.deg;
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                timeDate,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              Text(
                dayCard,
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  '$tempMaxCard °C',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Image.network(icon),
              // Image.network(icon, scale: 1.2, color: Colors.white),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  '$tempMinCard °C',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (deg > 45 && deg <= 135) ...[
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black54,
                    ),
                  ] else if (deg > 135 && deg <= 225) ...[
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.black54,
                    ),
                  ] else if (deg > 225 && deg <= 315) ...[
                    Icon(
                      Icons.arrow_back,
                      color: Colors.black54,
                    ),
                  ] else ...[
                    Icon(
                      Icons.arrow_upward,
                      color: Colors.black54,
                    )
                  ],
                  Text(
                    '$speedWind км/ч',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

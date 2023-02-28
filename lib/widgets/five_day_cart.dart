import 'package:flutter/material.dart';
import 'package:weather_jan/const/size_colors.dart';
import '../util/formatted.dart';

Widget fiveDayCard(AsyncSnapshot snapshot, int index) {
  final forecastList = snapshot.data?.list;
  final dayOfWeekCard = '';
  DateTime date =
      DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt * 1000);
  final timeDate = Util.getHourMinute(date);
  final monthDate = Util.getMonthDate(date), dayCard = monthDate; // Tue
  final tempMinCard = forecastList[index].main.tempMin.toStringAsFixed(0);
  final tempMaxCard = forecastList[index].main.tempMax.toStringAsFixed(0);
  final icon = forecastList[index].getIconUrl();
  final speedWind = forecastList[index].wind.speed.toStringAsFixed(1);
  final deg = forecastList[index].wind.deg;
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
                style: TextStyle(fontSize: sizeS, color: colorBlack54),
              ),
              Text(
                dayCard,
                style: TextStyle(fontSize: sizeXS, color: Colors.blue),
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
                    fontSize: sizeS,
                    color: colorBlack,
                  ),
                ),
              ),
              Image.network(icon),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text(
                  '$tempMinCard °C',
                  style: TextStyle(
                    fontSize: sizeS,
                    color: colorBlack,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (deg > 45 && deg <= 135)
                    Icon(
                      Icons.arrow_forward,
                      color: colorBlack54,
                    ),
                  if (deg > 135 && deg <= 225)
                    Icon(
                      Icons.arrow_downward,
                      color: colorBlack54,
                    ),
                  if (deg > 225 && deg <= 315)
                    Icon(
                      Icons.arrow_back,
                      color: colorBlack54,
                    ),
                  if (deg <= 45 && deg > 315)
                    Icon(
                      Icons.arrow_upward,
                      color: colorBlack54,
                    ),
                  Text(
                    '$speedWind км/ч',
                    style: TextStyle(color: colorBlack54),
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

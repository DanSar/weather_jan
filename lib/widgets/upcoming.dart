import 'package:flutter/material.dart';
import 'package:weather_jan/const/formatted.dart';
import 'package:weather_jan/models/models.dart';

class Upcoming extends StatelessWidget {
  final AsyncSnapshot<WeatherModels> snapshot;

  const Upcoming({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final forecastList = snapshot.data?.list;
    var dayOfWeek = '';
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(forecastList![2].dt! * 1000);
    final fullDate = Util.getFormattedDate(date);
    dayOfWeek = fullDate.split(',')[0]; // Wen
    // var dayOfWeekRu = Text(S.current.dayofWeek);
    final tempMin = forecastList[0].main?.temp_min?.toStringAsFixed(0);
    final tempMin1 = forecastList[7].main?.temp_min?.toStringAsFixed(0);
    final tempMin2 = forecastList[15].main?.temp_min?.toStringAsFixed(0);
    final tempMax = forecastList[0].main?.temp_max?.toStringAsFixed(0);
    final tempMax1 = forecastList[7].main?.temp_max?.toStringAsFixed(0);
    final tempMax2 = forecastList[15].main?.temp_max?.toStringAsFixed(0);
    final icon = forecastList[0].getIconUrl();
    final icon1 = forecastList[7].getIconUrl();
    final icon2 = forecastList[15].getIconUrl();
    return Column(
      children: [
        ListTile(
          leading: Image.network(
            icon,
            // color: Colors.white,
          ),
          title: const Text(
            'Сегодня',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$tempMax',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '°C/',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '$tempMin',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '°C',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Image.network(
            icon1,
            // color: Colors.white,
          ),
          title: Text(
            'Завтра',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$tempMax1',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '°C/',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '$tempMin1',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '°C',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Image.network(
            icon2,
            // color: Colors.white,
          ),
          title: Text(
            'Послезавтра',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$tempMax2',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '°C/',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '$tempMin2',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '°C',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

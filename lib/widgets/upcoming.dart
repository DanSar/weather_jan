import 'package:flutter/material.dart';
import 'package:weather_jan/const/size_colors.dart';
import '../domain/models/models.dart';
import '../util/formatted.dart';

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
    final tempMin = forecastList[0].main?.tempMin?.toStringAsFixed(0);
    final tempMin1 = forecastList[7].main?.tempMin?.toStringAsFixed(0);
    final tempMin2 = forecastList[15].main?.tempMin?.toStringAsFixed(0);
    final tempMax = forecastList[0].main?.tempMax?.toStringAsFixed(0);
    final tempMax1 = forecastList[7].main?.tempMax?.toStringAsFixed(0);
    final tempMax2 = forecastList[15].main?.tempMax?.toStringAsFixed(0);
    final icon = forecastList[0].getIconUrl();
    final icon1 = forecastList[7].getIconUrl();
    final icon2 = forecastList[15].getIconUrl();
    return Column(
      children: [
        ListTile(
          leading: Image.network(
            icon,
          ),
          title: Text(
            'Сегодня',
            style: TextStyle(color: colorText),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$tempMax',
                style: TextStyle(color: colorText),
              ),
              Text(
                '°C/',
                style: TextStyle(color: colorText),
              ),
              Text(
                '$tempMin',
                style: TextStyle(color: colorText),
              ),
              Text(
                '°C',
                style: TextStyle(color: colorText),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Image.network(
            icon1,
          ),
          title: Text(
            'Завтра',
            style: TextStyle(color: colorText),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$tempMax1',
                style: TextStyle(color: colorText),
              ),
              Text(
                '°C/',
                style: TextStyle(color: colorText),
              ),
              Text(
                '$tempMin1',
                style: TextStyle(color: colorText),
              ),
              Text(
                '°C',
                style: TextStyle(color: colorText),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Image.network(
            icon2,
          ),
          title: Text(
            'Послезавтра',
            style: TextStyle(color: colorText),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$tempMax2',
                style: TextStyle(color: colorText),
              ),
              Text(
                '°C/',
                style: TextStyle(color: colorText),
              ),
              Text(
                '$tempMin2',
                style: TextStyle(color: colorText),
              ),
              Text(
                '°C',
                style: TextStyle(color: colorText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

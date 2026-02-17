import 'package:flutter/material.dart';
import 'package:weather_jan/constants/size_colors.dart';
import '../models/models/models.dart';

class Upcoming extends StatelessWidget {
  final AsyncSnapshot<WeatherModels> snapshot;

  const Upcoming({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final forecastList = snapshot.data?.list;
    if (forecastList == null || forecastList.length < 16) {
      return const SizedBox.shrink(); // или CircularProgressIndicator()
    }

    final days = [
      _DayInfo(title: 'Сегодня', index: 0),
      _DayInfo(title: 'Завтра', index: 7),
      _DayInfo(title: 'послезавтра', index: 15),
    ];

    return Column(
      children: days.map((day) {
        final forecast = forecastList[day.index];
        final tempMin = forecast.main?.tempMin?.toStringAsFixed(0) ?? '--';
        final tempMax = forecast.main?.tempMax?.toStringAsFixed(0) ?? '--';
        final iconUrl = forecast.getIconUrl();

        return ListTile(
          leading: Image.network(iconUrl),
          title: Text(
            day.title,
            style: const TextStyle(color: colorText),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(tempMax, style: const TextStyle(color: colorText)),
              const Text('°C/', style: TextStyle(color: colorText)),
              Text(tempMin, style: const TextStyle(color: colorText)),
              const Text('°C', style: TextStyle(color: colorText)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Вспомогательный класс для типизации
class _DayInfo {
  final String title;
  final int index;

  const _DayInfo({required this.title, required this.index});
}

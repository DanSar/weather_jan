import 'package:flutter/material.dart';
import 'package:weather_jan/constants/size_colors.dart';
import '../models/models/models.dart';

class DetailedWeather extends StatelessWidget {
  final AsyncSnapshot<WeatherModels> snapshot;
  const DetailedWeather({super.key, required this.snapshot});

  static const _textStyle = TextStyle(color: colorText);
  static const _valueStyle = TextStyle(
    color: colorText,
    fontWeight: FontWeight.bold,
  );
  static const _mHgPerHPa = 0.7500638; // 1 hPa = 0.7500638 mmHg

  @override
  Widget build(BuildContext context) {
    final forecastList = snapshot.data?.list;

    // Защита от null
    if (forecastList == null || forecastList.isEmpty) {
      return const SizedBox.shrink();
    }

    final firstForecast = forecastList[0];

// Безопасное извлечение данных с значениями по умолчанию
    final feelsLike = firstForecast.main?.feelsLike;
    final feelsLikeValue =
        feelsLike != null ? feelsLike.round().toString() : '--';
    final popValue = firstForecast.pop != null
        ? (firstForecast.pop! * 100).round().toString()
        : '--';
    final windSpeed = firstForecast.wind?.speed?.toString() ?? '--';
    final himidity = firstForecast.main?.humidity.toString() ?? '--';

    final pressure = firstForecast.main?.pressure != null
        ? (firstForecast.main!.pressure! * _mHgPerHPa).round().toString()
        : '--'; //Атмосферное давление на уровне моря по умолчанию в Гектопаскаль(hPa)

    final clouds = firstForecast.clouds?.all?.toString() ?? '--';

    // Структура данных для отображения (левая и правая колонки)
    final weatherItems = [
      _WeatherItem(label: 'Ощущается', value: '$feelsLikeValue °С'),
      _WeatherItem(label: 'Вероятность дождя', value: '$popValue %'),
      _WeatherItem(label: 'Скорость ветра', value: '$windSpeed м/с'),
      _WeatherItem(label: 'Влажность', value: '$himidity %'),
      _WeatherItem(label: 'Давление', value: '$pressure mmHg'),
      _WeatherItem(label: 'Облачность', value: '$clouds %'),
    ];

    return Container(
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: MediaQuery.of(context).size.width / 2.4,
      decoration: BoxDecoration(
        color: colorWhite38,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 2,
        children: weatherItems
            .map((item) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.label, style: _textStyle),
                    Text(item.value, style: _valueStyle),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

// Вспомогательный класс для данных погоды
class _WeatherItem {
  final String label;
  final String value;

  const _WeatherItem({required this.label, required this.value});
}

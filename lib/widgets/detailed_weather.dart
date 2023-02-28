import 'package:flutter/material.dart';
import 'package:weather_jan/const/size_colors.dart';
import '../domain/models/models.dart';

class DetailedWeather extends StatelessWidget {
  final AsyncSnapshot<WeatherModels> snapshot;
  const DetailedWeather({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final forecastList = snapshot.data?.list;
    final feelsLike = forecastList![0].main?.feelsLike;
    final feelsLikeS = double.parse(feelsLike!.toStringAsFixed(0));
    final pop = forecastList[0].pop! * 100;
    final popS = pop.toStringAsFixed(0);
    final speed = forecastList[0].wind?.speed;
    final himidity = forecastList[0].main?.humidity;

    final mmGh = 0.7500638;
    final pressure = forecastList[0].main!.pressure! * mmGh;
    //Атмосферное давление на уровне моря по умолчанию в Гектопаскаль(hPa)
    // 1 hPa = 0.7500638 mmHg

    final clouds = forecastList[0].clouds?.all;
    return Container(
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.fromLTRB(20, 10, 90, 10),
      height: MediaQuery.of(context).size.width / 2.4,
      decoration: BoxDecoration(
        color: colorWhite38,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Ощущается',
                    style: TextStyle(color: colorText),
                  ),
                  Text(
                    '${feelsLikeS} °С',
                    style: TextStyle(color: colorText),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Вероятность дождя',
                    style: TextStyle(color: colorText),
                  ),
                  Text(
                    '${popS} %',
                    style: TextStyle(color: colorText),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Скорость ветра',
                    style: TextStyle(color: colorText),
                  ),
                  Text(
                    '${speed} м/с',
                    style: TextStyle(color: colorText),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Влажность',
                    style: TextStyle(color: colorText),
                  ),
                  Text(
                    '${himidity} %',
                    style: TextStyle(color: colorText),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Давление',
                    style: TextStyle(color: colorText),
                  ),
                  Text(
                    '${pressure.round()} mmHg',
                    style: TextStyle(color: colorText),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Облачность',
                    style: TextStyle(color: colorText),
                  ),
                  Text(
                    '${clouds} %',
                    style: TextStyle(color: colorText),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

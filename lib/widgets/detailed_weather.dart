import 'package:flutter/material.dart';
import 'package:weather_jan/const/componovka.dart';
import 'package:weather_jan/models/models.dart';

class DetailedWeather extends StatelessWidget {
  final AsyncSnapshot<WeatherModels> snapshot;
  const DetailedWeather({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var feelsLike = forecastList![0].main?.feels_like;
    var felsLike = double.parse(feelsLike!.toStringAsFixed(0));
    var pop = forecastList![0].pop! * 100;
    var speed = forecastList[0].wind?.speed;
    var himidity = forecastList[0].main?.humidity;
    var pressure = forecastList[0].main!.pressure! * 0.7500638;
    var clouds = forecastList[0].clouds?.all;
    return Container(
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.fromLTRB(20, 10, 90, 10),
      // width: MediaQuery.of(context).size.width / 1.1,
      height: MediaQuery.of(context).size.width / 2.4,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Componovka.getDetailedDouble('Ощущается', felsLike, '°С'),
              Componovka.getDetailedDouble('Вероятность дождя', pop, '%'),
              Componovka.getDetailedDouble('Скорость ветра', speed, 'м/с'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Componovka.getDetailedInt('Вероятность дождя', himidity!, '%'),
              Componovka.getDetailedInt('Давление', pressure.round(), 'mmHg'),
              Componovka.getDetailedInt('Облачность', clouds!, '%'),
            ],
          ),
        ],
      ),
    );
  }
}

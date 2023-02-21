import 'package:flutter/material.dart';
import 'package:weather_jan/models/models.dart';
import 'package:intl/intl.dart';

class MainTemp extends StatelessWidget {
  final AsyncSnapshot<WeatherModels> snapshot;
  const MainTemp({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var temp = forecastList?[0].main?.temp?.toStringAsFixed(0);
    var description = forecastList?[0].weather?[0].description;
    var beginningOfSentenceCaseDescription = toBeginningOfSentenceCase(
        description); //Чтобы использовать строку с заглавной буквы
    return Container(
      color: Colors.transparent,
      height: 440.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    '$temp',
                    style: const TextStyle(
                      fontSize: 100.0,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    '°C',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                '$beginningOfSentenceCaseDescription',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_jan/constants/size_colors.dart';
import '../models/models/models.dart';

class MainTemp extends StatelessWidget {
  final AsyncSnapshot<WeatherModels> snapshot;
  const MainTemp({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final sizeTemp = MediaQuery.of(context).size.height / 6.5;
    final sizeMain = MediaQuery.of(context).size.height / 1.7;
    final forecastList = snapshot.data?.list;
    final temp = forecastList?[0].main?.temp?.toStringAsFixed(0);
    final description = forecastList?[0].weather?[0].description;
    final beginningOfSentenceCaseDescription = toBeginningOfSentenceCase(
        description); //Чтобы использовать строку с заглавной буквы
    return Container(
      color: colorTransparent,
      height: sizeMain,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$temp',
                    style: TextStyle(
                      fontSize: sizeTemp,
                      color: colorText,
                    ),
                  ),
                  Container(
                    height: sizeTemp,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          '°C',
                          style: TextStyle(
                            fontSize: sizeM,
                            color: colorText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                '$beginningOfSentenceCaseDescription',
                style: TextStyle(
                  fontSize: sizeS,
                  color: colorText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

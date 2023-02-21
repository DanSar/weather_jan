import 'package:flutter/material.dart';
import 'package:weather_jan/widgets/hourly_card.dart';
import '../models/models.dart';

class HourlyListView extends StatelessWidget {
  final AsyncSnapshot<WeatherModels> snapshot;
  const HourlyListView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 200,
      padding: EdgeInsets.symmetric(vertical: 26, horizontal: 2),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemCount: 8,
        itemBuilder: (context, index) => Container(
          width: MediaQuery.of(context).size.width / 4.2,
          height: 160,
          color: Colors.transparent,
          child: hourlyCard(snapshot, index),
        ),
      ),
    );
  }
}

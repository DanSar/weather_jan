import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_jan/widgets/five_day_cart.dart';
import '../models/models.dart';

class FiveDayScreen extends StatelessWidget {
  final AsyncSnapshot<WeatherModels> snapshot;
  const FiveDayScreen({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    // var forecastList = snapshot.data?.list;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // title: Text('ScreenForecast'),
          leading: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.arrowLeftLong,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Прогноз на 5 дней',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 440,
            padding: EdgeInsets.symmetric(vertical: 46, horizontal: 0),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 4),
              itemCount: snapshot.data!.list!.length,
              itemBuilder: (context, index) => Container(
                width: MediaQuery.of(context).size.width / 5,
                height: 160,
                color: (index == 0) ? Colors.black12 : Colors.white,
                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                // Colors.lightBlue[300],
                child: fiveDayCard(snapshot, index),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

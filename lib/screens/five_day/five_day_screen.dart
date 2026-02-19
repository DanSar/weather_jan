import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_jan/constants/size_colors.dart';
import 'package:weather_jan/widgets/five_day_cart.dart';
import '../../models/models/models.dart';

class FiveDayScreen extends StatelessWidget {
  final AsyncSnapshot<WeatherModels> snapshot;
  const FiveDayScreen({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: colorText,
        appBar: AppBar(
          backgroundColor: colorText,
          elevation: 0,
          leading: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.arrowLeftLong,
              color: colorBlack,
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
                fontSize: sizeL,
                color: colorBlack,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: colorText,
            height: 440,
            padding: EdgeInsets.symmetric(vertical: 46, horizontal: 0),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 4),
              itemCount: snapshot.data!.list!.length,
              itemBuilder: (context, index) => Container(
                width: MediaQuery.of(context).size.width / 4.2,
                height: 160,
                color: (index == 0) ? Colors.black12 : colorText,
                child: fiveDayCard(snapshot, index),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

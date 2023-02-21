import 'package:flutter/material.dart';

class ImagePresenter extends StatelessWidget {
  const ImagePresenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image(
          image: AssetImage('images/weather_forecast.jpg'),
        ),
      ),
    );
  }
}

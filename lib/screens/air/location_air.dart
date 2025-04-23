import 'package:flutter/material.dart';
import 'package:weather_jan/const/size_colors.dart';
import 'package:weather_jan/screens/air/screen_index_air.dart';

import '../../api/air_api.dart';

class LocationAir extends StatefulWidget {
  @override
  State<LocationAir> createState() => _LocationAirState();
}

class _LocationAirState extends State<LocationAir> {
  void getLocationAir() async {
    try {
      var airInfo = await AirApi().fetchAirPollution();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ScreenIndexAir(locationAir: airInfo);
      }));
    } catch (a) {
      print('$a');
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationAir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: colorProgressIndicator,
        ),
      ),
    );
  }
}

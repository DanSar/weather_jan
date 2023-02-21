import 'package:flutter/material.dart';
import 'package:weather_jan/screens/location_screen.dart';
import '../models/modelsAir.dart';

class ScreenIndexAir extends StatefulWidget {
  final locationAir;
  const ScreenIndexAir({this.locationAir});

  @override
  State<ScreenIndexAir> createState() => _ScreenIndexAirState();
}

class _ScreenIndexAirState extends State<ScreenIndexAir> {
  late Future<AirPollution?> airObject;

  @override
  void initState() {
    super.initState();
    if (widget.locationAir != null) {
      airObject = Future.value(widget.locationAir);
    }
  }

  @override
  Widget build(BuildContext context) {
    // var forecastList = snapshot.data?.list;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LocationScreen();
              }));
            },
          ),
          title: Text('Index Air'),
        ),
        body: FutureBuilder<AirPollution?>(
          future: airObject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Индекс качества воздуха(по шкале 1-5)",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 40),
                    Text(
                      '${snapshot.data!.list?[0].main?.aqi}',
                      style: TextStyle(fontSize: 80),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.co}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text('co'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.no}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text('no'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.no2}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text('no2'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.o3}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text('o3'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.so2}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text('so2'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.pm2_5}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text('pm25'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.pm10}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text('pm10'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.nh3}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text('nh3'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Divider(
                      color: Colors.black,
                    ),
                    Text('Open Weather'),
                  ],
                ),
              );
            } else {
              return Text('Error');
            }
          },
        ),
      ),
    );
  }
}

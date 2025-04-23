import 'package:flutter/material.dart';
import 'package:weather_jan/screens/location_screen.dart';
import '../domain/modelsAir/modelsAir.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LocationScreen();
              }));
            },
          ),
        ),
        body: FutureBuilder<AirPollution?>(
          future: airObject,
          builder: (context, snapshot) {
            var color = Colors.black;
            String qualitativeName = '';
            var aqi = snapshot.data?.list?[0].main?.aqi;
            final sizeAir = MediaQuery.of(context).size.height / 8.5;

            if (aqi == 5) {
              color = Colors.red;
              qualitativeName = 'Очень плохое';
            }
            if (aqi == 4) {
              color = Colors.orange;
              qualitativeName = 'Плохое';
            }
            if (aqi == 3) {
              color = Colors.orange.shade200;
              qualitativeName = 'Умеренное';
            }
            if (aqi == 2) {
              color = Colors.green.shade200;
              qualitativeName = 'Хорошее';
            }
            if (aqi == 1) {
              color = Colors.green;
              qualitativeName = 'Отличное';
            }
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      "Индекс качества воздуха(по шкале 1-5)",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            '$aqi',
                            style: TextStyle(fontSize: sizeAir, color: color),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            height: sizeAir,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  qualitativeName,
                                  style: TextStyle(color: color, fontSize: 24),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.co}',
                                style: TextStyle(fontSize: 24, color: color),
                              ),
                              Text('CO'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.no}',
                                style: TextStyle(fontSize: 24, color: color),
                              ),
                              Text('NO'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.no2}',
                                style: TextStyle(fontSize: 24, color: color),
                              ),
                              Text('NO2'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.o3}',
                                style: TextStyle(fontSize: 24, color: color),
                              ),
                              Text('O3'),
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
                                style: TextStyle(fontSize: 24, color: color),
                              ),
                              Text('SO2'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.pm25}',
                                style: TextStyle(fontSize: 24, color: color),
                              ),
                              Text('PM25'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.pm10}',
                                style: TextStyle(fontSize: 24, color: color),
                              ),
                              Text('PM10'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '${snapshot.data!.list?[0].components?.nh3}',
                                style: TextStyle(fontSize: 24, color: color),
                              ),
                              Text('NH3'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Divider(
                      color: Colors.black,
                    ),
                    TextButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  content: Text(
                                      'Индекс качества воздуха(по шкале 1-5), '
                                      'где 1 - отличное качество воздуха, а 5 - ужасное.'
                                      'Помимо базового индекса качества воздуха, '
                                      'API возвращает данные о загрязняющих газах, '
                                      'таких как монооксид углерода (CO), монооксид азота (NO), '
                                      'диоксид азота (NO2), Озон (O3), Диоксид серы (SO2), '
                                      'аммиак (NH3) и твердых частиц (2.5 и 10 вечера)'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Подробнее о качестве воздуха',
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(
                              Icons.arrow_right_sharp,
                              color: Colors.black,
                            )
                          ],
                        )),
                    Text(
                      'Open Weather',
                      style: TextStyle(color: Colors.black54),
                    ),
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

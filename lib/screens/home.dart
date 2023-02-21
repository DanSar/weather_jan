import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_jan/const/weather_api.dart';
import 'package:weather_jan/models/models.dart';
import 'package:weather_jan/screens/five_day_screen.dart';
import 'package:weather_jan/screens/location_air.dart';
import 'package:weather_jan/widgets/data_source.dart';
import 'package:weather_jan/widgets/detailed_weather.dart';
import 'package:weather_jan/widgets/hourly_list_view.dart';
import 'package:weather_jan/widgets/image.dart';
import 'package:weather_jan/widgets/main_temperature.dart';
import 'package:weather_jan/widgets/upcoming.dart';
import 'city_screen.dart';

class MyHomePage extends StatefulWidget {
  final locationWeather;
  const MyHomePage({this.locationWeather});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<WeatherModels> forecastObject;
  late String cityName;

  @override
  void initState() {
    super.initState();
    if (widget.locationWeather != null) {
      forecastObject = Future.value(widget.locationWeather);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/nebo.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0, // Тень
            leading: IconButton(
              onPressed: () async {
                var tappedName = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return CityScreen();
                }));
                if (tappedName != null) {
                  setState(() {
                    cityName = tappedName;
                    forecastObject = WeatherApi()
                        .fetchWeatherCity(city: cityName, isCity: true); // TRUE
                  });
                }
              },
              icon: const Icon(Icons.search),
            ),
            title: FutureBuilder<WeatherModels>(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final city = snapshot.data?.city?.name;
                  return Center(child: Text('$city'));
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      forecastObject = WeatherApi().fetchWeatherCity(); // null
                    });
                  },
                  icon: FaIcon(FontAwesomeIcons.wrench))
            ],
          ),
          body: ListView(
            children: [
              Container(
                child: FutureBuilder<WeatherModels>(
                  future: forecastObject,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          MainTemp(snapshot: snapshot),
                          Upcoming(snapshot: snapshot),
                          // BottonForecast(forecastObject),
                          Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 24.0),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white38),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    // side: BorderSide(color: Colors.white38),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return FiveDayScreen(snapshot: snapshot);
                                }));
                              },
                              child: Text(
                                'Прогноз на 5 дней',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          ImagePresenter(),
                          HourlyListView(snapshot: snapshot),
                          DetailedWeather(snapshot: snapshot),
                          Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 24.0),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white38),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    // side: BorderSide(color: Colors.white38),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LocationAir();
                                }));
                              },
                              child: Text(
                                'Индекс качества воздуха',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          DataSource(),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Город не найден\nПожалуйста, правильно введите название города',
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

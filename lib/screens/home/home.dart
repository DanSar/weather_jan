import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_jan/constants/size_colors.dart';
import 'package:weather_jan/screens/five_day/five_day_screen.dart';
import 'package:weather_jan/widgets/data_source.dart';
import 'package:weather_jan/widgets/detailed_weather.dart';
import 'package:weather_jan/widgets/hourly/hourly_list_view.dart';
import 'package:weather_jan/widgets/image.dart';
import 'package:weather_jan/widgets/main_temperature.dart';
import 'package:weather_jan/widgets/upcoming.dart';
import '../../api/weather_api.dart';
import '../../models/models/models.dart';
import '../air/location_air.dart';
import '../city/city_screen.dart';

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
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/nebo.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: colorTransparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: colorTransparent,
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
                      color: colorProgressIndicator,
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
                          Container(
                            width: double.infinity,
                            color: colorTransparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 24.0),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(colorWhite38),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
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
                                style: TextStyle(color: colorText),
                              ),
                            ),
                          ),
                          ImagePresenter(),
                          HourlyListView(snapshot: snapshot),
                          DetailedWeather(snapshot: snapshot),
                          Container(
                            width: double.infinity,
                            color: colorTransparent,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 24.0),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(colorWhite38),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
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
                                style: TextStyle(color: colorText),
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

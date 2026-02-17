import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:weather_jan/constants/api_requests.dart';
import '../../models/models/models.dart';
import '../utils/location.dart';

class WeatherApi {
  Future<WeatherModels> fetchWeatherCity(
      {String? city, bool? isCity = false}) async {
    final client = http.Client();

    try {
      Location location = Location();
      await location.getCurrentLocation();

      Map<String, String?> parameters;

      if (isCity == true && city != null) {
        parameters = {
          'appid': ApiRequests.weatherAppId,
          'units': 'metric',
          'q': city,
          'lang': 'ru',
        };
      } else {
        parameters = {
          'appid': ApiRequests.weatherAppId,
          'units': 'metric',
          'lat': location.latitude?.toString() ?? '',
          'lon': location.longitude?.toString() ?? '',
          'lang': 'ru',
        };
      }

      final uri = Uri.https(
        ApiRequests.weatherBaseUrlDomain,
        ApiRequests.weatherForecastPath,
        parameters,
      );

      log('request: ${uri.toString()}');

      final response = await http.get(uri);

      log('response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return WeatherModels.fromJson(json.decode(response.body));
      } else {
        throw Exception('Ошибка загрузки погоды: ${response.statusCode}');
      }
    } finally {
      client.close();
    }
  }
}

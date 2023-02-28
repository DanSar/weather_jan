import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:weather_jan/const/api_requests.dart';
import '../../domain/models/models.dart';
import '../util/location.dart';

class WeatherApi {
  Future<WeatherModels> fetchWeatherCity({String? city, bool? isCity}) async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, String?> parameters;

    if (isCity == true) {
      var queryParameters = {
        'appid': ApiRequests.WEATHER_APP_ID,
        'units': 'metric',
        'q': city,
        'lang': 'ru',
      };
      parameters = queryParameters;
    } else {
      var queryParameters = {
        'appid': ApiRequests.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'lang': 'ru',
      };
      parameters = queryParameters;
    }

    Uri uri = Uri.https(ApiRequests.WEATHER_BASE_URL_DOMAIN,
        ApiRequests.WEATHER_FORECAST_PATH, parameters);

    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    print('response: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherModels.fromJson(json.decode(response.body));
    } else {
      return Future.error('Ошибка');
    }
  }
}

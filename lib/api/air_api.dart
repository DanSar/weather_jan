import 'dart:convert';
import 'dart:developer';
import 'package:weather_jan/constants/api_requests.dart';
import 'package:http/http.dart' as http;
import '../models/modelsAir/models_air.dart';
import '../utils/location.dart';

class AirApi {
  Future<AirPollution?> fetchAirPollution({bool? isCity}) async {
    final client = http.Client();

    try {
      Location location = Location();
      await location.getCurrentLocation();

      final parameters = {
        'lat': location.latitude?.toString() ?? '',
        'lon': location.longitude?.toString() ?? '',
        'APPID': ApiRequests.weatherAppId,
      };

      final uri = Uri.https(
        ApiRequests.weatherBaseUrlDomain,
        ApiRequests.airPath,
        parameters,
      );

      log('request: ${uri.toString()}');

      final response = await client.get(uri);

      log('response status: ${response.statusCode}');
      log('response body: ${response.body}');

      if (response.statusCode == 200) {
        return AirPollution.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Ошибка загрузки данных о качестве воздуха: ${response.statusCode}');
      }
    } finally {
      client.close();
    }
  }
}

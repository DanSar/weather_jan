import 'dart:convert';
import 'dart:developer';
import 'package:weather_jan/const/api_requests.dart';
import 'package:http/http.dart' as http;
import '../../domain/modelsAir/modelsAir.dart';
import '../util/location.dart';

class AirApi {
  Future<AirPollution?> fetchAirPollution({bool? isCity}) async {
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, String> parameters;
    var query = {
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString(),
      'APPID': ApiRequests.WEATHER_APP_ID,
    };
    parameters = query;
    Uri uri = Uri.https(
        ApiRequests.WEATHER_BASE_URL_DOMAIN, ApiRequests.AIR_PATH, parameters);

    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    print('response: ${response.body}');

    if (response.statusCode == 200) {
      return AirPollution.fromJson(json.decode(response.body));
    } else {
      return Future.error('Ошибка');
    }
  }
}

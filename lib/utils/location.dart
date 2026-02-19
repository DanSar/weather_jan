import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Проверьте, включены ли службы определения местоположения.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Службы определения местоположения не включены
      // не продолжайте получать доступ к местоположению
      // и запрашивайте пользователей приложения
      // включить службы определения местоположения.
      return Future.error('службы определения местоположения не выключены');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // В разрешениях отказано, в следующий раз
        // вы можете попробовать запросить разрешения
        // снова (это также тот случай, когда
        // Android shouldShowRequestPermissionRationale
        // вернул true. Согласно рекомендациям Android,
        // теперь ваше приложение должно отображать
        // пояснительный пользовательский интерфейс.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // В разрешениях отказано навсегда, обращайтесь соответствующим образом.
      return Future.error('Разрешения навсегда отклонены');
    }

    // Когда мы доберемся сюда, разрешения будут предоставлены,
    // и мы сможем продолжить доступ к местоположению устройства.
    try {
      Position position = await Geolocator.getCurrentPosition(
              locationSettings: LocationSettings(
                  accuracy: LocationAccuracy.best, distanceFilter: 0))
          .timeout(Duration(seconds: 10));
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      log('Ошибка получения локации: $e');
      rethrow;
    }
  }
}

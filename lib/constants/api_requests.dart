class ApiRequests {
  static const String weatherAppId = 'f35ee09e7ff055b16e891936a097a671';
  static const String weatherBaseScheme = 'https://';
  static const String weatherBaseUrlDomain = 'api.openweathermap.org';
  static const String weatherForecastPath = '/data/2.5/forecast';
  static const String weatherImagesPath = '/img/w/';
  static const String weatherImagesUrl =
      '$weatherBaseScheme$weatherBaseUrlDomain$weatherImagesPath';
  static const String airPath = 'data/2.5/air_pollution';
}

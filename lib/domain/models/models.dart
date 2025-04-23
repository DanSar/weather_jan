import 'package:json_annotation/json_annotation.dart';
import 'package:weather_jan/const/api_requests.dart';

part 'models.g.dart';

@JsonSerializable()
class WeatherModels {
  String? cod;
  int? message;
  int? cnt;
  List<WeatherList>? list;
  City? city;

  WeatherModels({this.cod, this.message, this.cnt, this.list, this.city});

  factory WeatherModels.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelsFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelsToJson(this);
}

@JsonSerializable()
class WeatherList {
  int? dt; //Прогнозируемое время данных, unix, UTC
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind; // Ветер(скорость, направление, порывистость)
  int?
      visibility; // Средняя видимость, метров. Максимальное значение видимости составляет 10 км
  double? pop; //Probability of precipitation — вероятность осадков
  Sys? sys; //Часть дня (n - ночь, d - день)
  String? dtTxt; //Прогнозируемое время получения данных, ISO, UTC

  WeatherList(
      {this.dt,
      this.main,
      this.weather,
      this.clouds,
      this.wind,
      this.visibility,
      this.pop, //Probability of precipitation — вероятность осадков
      this.sys, //Часть дня (n - ночь, d - день)
      this.dtTxt});

  factory WeatherList.fromJson(Map<String, dynamic> json) =>
      _$WeatherListFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherListToJson(this);

  String getIconUrl() {
    return '${ApiRequests.WEATHER_IMAGES_URL}${weather?[0].icon}.png';
  }
}

@JsonSerializable()
class Main {
  double? temp; //Температура

  @JsonKey(name: 'feels_like')
  double?
      feelsLike; //Этот температурный параметр определяет восприятие погоды человеком

  @JsonKey(name: 'temp_min')
  double? tempMin; // Минимальная температура на момент расчета

  @JsonKey(name: 'temp_max')
  double? tempMax; //Максимальная температура на момент расчета

  int?
      pressure; //Атмосферное давление на уровне моря по умолчанию в Гектопаскаль(hPa)
  // 1 hPa = 0.7500638 mmHg

  @JsonKey(name: 'sea_level')
  int? seaLevel; //Атмосферное давление на уровне моря

  @JsonKey(name: 'grnd_level')
  int? grndLevel; //Атмосферное давление на уровне земли

  int? humidity; //Влажность, %

  @JsonKey(name: 'temp_kf')
  double? tempKf; //Внутренний параметр

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.grndLevel,
      this.humidity,
      this.tempKf});

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Weather {
  int? id; //Идентификатор погодных условий
  String?
      main; //Группа погодных параметров (дождь, снег, экстремальные условия и т.д.)
  String? description; // Погодные условия в группе
  String? icon; //Идентификатор значка погоды

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

/// облачность:
@JsonSerializable()
class Clouds {
  int? all; //Облачность, %

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

/// ветер:
@JsonSerializable()
class Wind {
  double? speed; //Скорость ветра
  int? deg; //Направление ветра, градусов (метеорологический)
  double? gust; //Порывистый ветер

  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

/// часть дня:
@JsonSerializable()
class Sys {
  String? pod; //Часть дня (n - ночь, d - день)

  Sys({this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}

/// город:
@JsonSerializable()
class City {
  int? id; //Идентификатор города
  String? name; //Название города.
  Coord? coord; //Географическое положение города
  String? country; //Код страны
  int? population; //Население города
  int? timezone; //Сдвиг в секундах от UTC
  int? sunrise; //Время восхода солнца, Unix, UTC
  int? sunset; //Время захода солнца, Unix, UTC

  City(
      {this.id,
      this.name,
      this.coord,
      this.country,
      this.population,
      this.timezone,
      this.sunrise,
      this.sunset});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}

///географическое положение города:
@JsonSerializable()
class Coord {
  double? lat; //Географическое положение города, широта
  double? lon; //Географическое положение города, долгота

  Coord({this.lat, this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

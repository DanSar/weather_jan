import 'package:json_annotation/json_annotation.dart';

part 'modelsAir.g.dart';

@JsonSerializable()
class AirPollution {
  Coord? coord;
  List<AirList>? list;

  AirPollution({this.coord, this.list});

  factory AirPollution.fromJson(Map<String, dynamic> json) =>
      _$AirPollutionFromJson(json);

  Map<String, dynamic> toJson() => _$AirPollutionToJson(this);
}

@JsonSerializable()
class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class AirList {
  Main? main;
  Components? components;
  int? dt;

  AirList({this.main, this.components, this.dt});

  factory AirList.fromJson(Map<String, dynamic> json) =>
      _$AirListFromJson(json);

  Map<String, dynamic> toJson() => _$AirListToJson(this);
}

@JsonSerializable()
class Main {
  int? aqi;

  Main({this.aqi});

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Components {
  double? co;
  double? no;
  double? no2;
  double? o3;
  double? so2;
  double? pm2_5;
  double? pm10;
  double? nh3;

  Components(
      {this.co,
      this.no,
      this.no2,
      this.o3,
      this.so2,
      this.pm2_5,
      this.pm10,
      this.nh3});

  factory Components.fromJson(Map<String, dynamic> json) =>
      _$ComponentsFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentsToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_air.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirPollution _$AirPollutionFromJson(Map<String, dynamic> json) => AirPollution(
      coord: json['coord'] == null
          ? null
          : Coord.fromJson(json['coord'] as Map<String, dynamic>),
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AirList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AirPollutionToJson(AirPollution instance) =>
    <String, dynamic>{
      'coord': instance.coord,
      'list': instance.list,
    };

Coord _$CoordFromJson(Map<String, dynamic> json) => Coord(
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

AirList _$AirListFromJson(Map<String, dynamic> json) => AirList(
      main: json['main'] == null
          ? null
          : Main.fromJson(json['main'] as Map<String, dynamic>),
      components: json['components'] == null
          ? null
          : Components.fromJson(json['components'] as Map<String, dynamic>),
      dt: (json['dt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AirListToJson(AirList instance) => <String, dynamic>{
      'main': instance.main,
      'components': instance.components,
      'dt': instance.dt,
    };

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      aqi: (json['aqi'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'aqi': instance.aqi,
    };

Components _$ComponentsFromJson(Map<String, dynamic> json) => Components(
      co: (json['co'] as num?)?.toDouble(),
      no: (json['no'] as num?)?.toDouble(),
      no2: (json['no2'] as num?)?.toDouble(),
      o3: (json['o3'] as num?)?.toDouble(),
      so2: (json['so2'] as num?)?.toDouble(),
      pm2_5: (json['pm2_5'] as num?)?.toDouble(),
      pm10: (json['pm10'] as num?)?.toDouble(),
      nh3: (json['nh3'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ComponentsToJson(Components instance) =>
    <String, dynamic>{
      'co': instance.co,
      'no': instance.no,
      'no2': instance.no2,
      'o3': instance.o3,
      'so2': instance.so2,
      'pm2_5': instance.pm2_5,
      'pm10': instance.pm10,
      'nh3': instance.nh3,
    };

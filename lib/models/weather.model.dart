import 'dart:convert';

import 'package:flutter/foundation.dart';

class WeatherModel {
  final DateTime? localTime;
  final DateTime? lastUpdated;
  final String? location;
  final double? temp;
  final double? feelsLike;
  final String? condition;
  final String? conditionImage;
  final double? wind;
  final dynamic humidity;
  final List<WeatherModel>? forecast;

  const WeatherModel({
    required this.localTime,
    required this.lastUpdated,
    required this.location,
    required this.temp,
    required this.feelsLike,
    required this.condition,
    required this.conditionImage,
    required this.wind,
    required this.humidity,
    required this.forecast,
  });

  WeatherModel copyWith({
    DateTime? localTime,
    DateTime? lastUpdated,
    String? location,
    double? temp,
    double? feelsLike,
    String? condition,
    String? conditionImage,
    double? wind,
    dynamic humidity,
    List<WeatherModel>? forecast,
  }) {
    return WeatherModel(
      localTime: localTime ?? this.localTime,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      condition: condition ?? this.condition,
      conditionImage: conditionImage ?? this.conditionImage,
      wind: wind ?? this.wind,
      humidity: humidity ?? this.humidity,
      forecast: forecast ?? this.forecast,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'localTime': localTime?.millisecondsSinceEpoch,
      'lastUpdated': lastUpdated?.millisecondsSinceEpoch,
      'location': location,
      'temp': temp,
      'feelsLike': feelsLike,
      'condition': condition,
      'conditionImage': conditionImage,
      'wind': wind,
      'humidity': humidity,
      'forecast': forecast?.map((x) => x.toMap()).toList(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      localTime: map["location"] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map["location"]["localtime_epoch"] as int)
          : map["date_epoch"] != null
              ? DateTime.fromMillisecondsSinceEpoch(map["date_epoch"] as int)
              : null,
      lastUpdated: map["current"] != null
          ? DateTime.tryParse(map["current"]['last_updated'] as String)
          : null,
      location:
          map['location'] != null ? map['location']["name"] as String : null,
      temp: map["current"] != null
          ? map["current"]['temp_c'] as double
          : map["day"] != null
              ? map["day"]['avgtemp_c'] as double
              : null,
      feelsLike: map["current"] != null
          ? map["current"]['feelslike_c'] as double
          : null,
      condition: map["current"] != null
          ? map["current"]['condition']["text"].toString().split("or ").last
          : null,
      conditionImage: map["current"] != null
          ? "https:${map['current']['condition']['icon']}"
          : map["day"] != null
              ? "https:${map['day']['condition']['icon']}"
              : null,
      wind: map["current"] != null
          ? map["current"]['wind_kph'] as double
          : map["day"] != null
              ? map["day"]['maxwind_kph'] as double
              : null,
      humidity: map["current"] != null
          ? map["current"]['humidity'] as int
          : map["day"] != null
              ? map["day"]['avghumidity'] as double
              : null,
      forecast: map["forecast"] != null
          ? List<WeatherModel>.from(
              (map['forecast']["forecastday"] as List<dynamic>)
                  .map<WeatherModel>(
                (x) => WeatherModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(localTime: $localTime, lastUpdated: $lastUpdated, location: $location, temp: $temp, condition: $condition, conditionImage: $conditionImage, wind: $wind, humidity: $humidity, forecast: $forecast)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.localTime == localTime &&
        other.lastUpdated == lastUpdated &&
        other.location == location &&
        other.temp == temp &&
        other.condition == condition &&
        other.conditionImage == conditionImage &&
        other.wind == wind &&
        other.humidity == humidity &&
        listEquals(other.forecast, forecast);
  }

  @override
  int get hashCode {
    return localTime.hashCode ^
        lastUpdated.hashCode ^
        location.hashCode ^
        temp.hashCode ^
        condition.hashCode ^
        conditionImage.hashCode ^
        wind.hashCode ^
        humidity.hashCode ^
        forecast.hashCode;
  }
}

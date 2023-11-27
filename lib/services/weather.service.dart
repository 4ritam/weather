import 'dart:convert';
import 'package:http/http.dart';
import '../models/weather.model.dart';

class WeatherService {
  static const baseURL = "https://api.weatherapi.com/v1/forecast.json";
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<WeatherModel> getCurrentWeather(String location) async {
    final response = await get(Uri.parse(
        '$baseURL?q=$location&days=4&hour=0&alerts=no&aqi=no&key=$apiKey'));
    if (response.statusCode == 200) {
      final res = WeatherModel.fromMap(jsonDecode(response.body));
      return res;
    } else {
      throw Exception("failed to load weather data.");
    }
  }
}

import 'dart:async';

import 'package:get/get.dart';

import '../models/weather.model.dart';
import '../services/weather.service.dart';

class WeatherController extends GetxController {
  WeatherService weatherService =
      WeatherService(apiKey: 'a081f1a9fe694c9f94b92852231811');
  RxList<WeatherModel> weatherData = RxList.empty();
  RxList<String> locations =
      RxList.from(["agartala", "delhi", "kolkata", "mumbai"]);

  Rx<int> defaultLocation = 0.obs;

  @override
  void onInit() async {
    await getWeatherData();
    super.onInit();
  }

  void changeDefaultLocation(int index) {
    defaultLocation.value = index;
  }

  String get currentWeatherVideo {
    String condition =
        weatherData[defaultLocation.value].condition!.toLowerCase();
    List<String> sunny = ["sunny", "cloud", "clear"];
    List<String> haze = ["mist", "overcast", "fog"];
    List<String> rainy = ["rain", "thunder", "drizzle"];
    for (String s in sunny) {
      if (condition.contains(s)) {
        return "sunny";
      }
    }
    for (String s in haze) {
      if (condition.contains(s)) {
        return "cloudy";
      }
    }
    for (String s in rainy) {
      if (condition.contains(s)) {
        return "rain";
      }
    }
    return "snow";
  }

  WeatherModel get currentWeather => weatherData[defaultLocation.value];

  Future<void> getWeatherData() async {
    List<WeatherModel> res = [];
    for (String l in locations) {
      WeatherModel data = await weatherService.getCurrentWeather(l);
      res.add(data);
    }
    weatherData.clear();
    weatherData.addAll(res);
    await Future.delayed(const Duration(seconds: 5));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_getx/controller/weather.controllrer.dart';
import 'package:weather_getx/screens/location_list/location_list.screen.dart';
import 'package:weather_getx/screens/weather/weather.screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController =
        Get.put(WeatherController(), permanent: true);

    return GetMaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColorDark: Colors.white,
          scaffoldBackgroundColor: Colors.transparent),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      home: Obx(() {
        if (weatherController.locations.isEmpty) {
          return LocationListScreen(
            weatherData: weatherController.weatherData,
            changeScreen: weatherController.changeDefaultLocation,
          );
        } else if (weatherController.weatherData.isNotEmpty) {
          return WeatherScreen(
            currentWeatherImage: weatherController.currentWeatherVideo,
            weatherDataList: weatherController.weatherData,
            weatherData: weatherController.currentWeather,
            changeScreen: weatherController.changeDefaultLocation,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

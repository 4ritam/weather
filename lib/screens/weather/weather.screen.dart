import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_getx/screens/location_list/location_list.screen.dart';

import '../../models/weather.model.dart';
import 'widgets/widgets.dart';

class WeatherScreen extends StatelessWidget {
  final List<WeatherModel> weatherDataList;
  final WeatherModel weatherData;
  final void Function(int) changeScreen;
  final String currentWeatherImage;
  const WeatherScreen({
    super.key,
    required this.weatherData,
    required this.weatherDataList,
    required this.changeScreen,
    required this.currentWeatherImage,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset("assets/$currentWeatherImage.gif"),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.black38,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    Get.to(() {
                      return LocationListScreen(
                          weatherData: weatherDataList,
                          changeScreen: changeScreen);
                    });
                  },
                ),
              ],
              title: Row(
                children: [
                  const Icon(Icons.pin_drop),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(weatherData.location!)
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        children: [
                          Text(
                            DateFormat('MMM d, E').format(DateTime.now()),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 40,
                              shadows: [
                                Shadow(
                                  blurRadius: 5.0,
                                  color: Colors.black54,
                                  offset: Offset(
                                    1.0,
                                    1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Updated ${DateFormat('d/M/yyy h:mm a').format(weatherData.lastUpdated!)}",
                            style: const TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 8.0,
                                  color: Colors.black54,
                                  offset: Offset(
                                    1.0,
                                    2.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: WeatherInfo(
                        weatherCondition: weatherData.condition,
                        icon: weatherData.conditionImage,
                        temperature: weatherData.temp,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      AdditionalInfoItem(
                        context: context,
                        info: "Humidity",
                        data: "${weatherData.humidity.toString()}%",
                        icon: Icons.water_drop_outlined,
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      AdditionalInfoItem(
                        context: context,
                        info: "Wind",
                        data: "${weatherData.wind.toString()}km/h",
                        icon: Icons.wind_power_outlined,
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      AdditionalInfoItem(
                        context: context,
                        info: "Feels Like",
                        data: "${weatherData.feelsLike!.round().toString()}°C",
                        icon: Icons.thermostat,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Card(
                    margin: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    color: const Color.fromARGB(59, 41, 41, 41),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: weatherData.forecast!.map((e) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: DailyForecastItem(
                                day: e.localTime!,
                                icon: e.conditionImage!,
                                temperature: e.temp!,
                                wind: e.wind!,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

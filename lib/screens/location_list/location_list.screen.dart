import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/weather.model.dart';

class LocationListScreen extends StatelessWidget {
  final List<WeatherModel> weatherData;
  final void Function(int) changeScreen;
  const LocationListScreen({
    super.key,
    required this.weatherData,
    required this.changeScreen,
  });

  void openWeatherScreen(BuildContext context, int index) {
    changeScreen(index);
    Get.back();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.2, 0.35, 0.9],
            colors: [
              Color.fromARGB(255, 61, 11, 106),
              Color.fromARGB(255, 17, 19, 100),
              Color.fromARGB(255, 37, 7, 64),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 70,
                leadingWidth: 0,
                leading: Container(),
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text(
                  "Saved Locations",
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_rounded,
                      size: 40,
                    ),
                  )
                ],
              ),
              body: ListView(
                children: [
                  ...weatherData
                      .map((e) => Container(
                            padding: const EdgeInsets.all(8.0),
                            height: 180,
                            child: Center(
                              child: GestureDetector(
                                onTap: () => openWeatherScreen(
                                    context, weatherData.indexOf(e)),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  color:
                                      const Color.fromRGBO(170, 165, 165, 0.45),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.location!,
                                              style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w900,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 8.0,
                                                    color: Colors.black54,
                                                    offset: Offset(
                                                      0.0,
                                                      3.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(
                                              flex: 2,
                                            ),
                                            FittedBox(
                                              child: Text(
                                                e.condition!,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Spacer(
                                              flex: 5,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  const TextSpan(
                                                      text: 'Humidity ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  TextSpan(
                                                    text: '${e.humidity}%',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  const TextSpan(
                                                      text: 'Wind ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  TextSpan(
                                                    text: '${e.wind}km/h',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Image.network(e.conditionImage!),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.temp != null
                                                      ? e.temp!
                                                          .round()
                                                          .toString()
                                                      : "--",
                                                  style: const TextStyle(
                                                    fontSize: 48,
                                                    fontWeight: FontWeight.w600,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 18.0,
                                                        color: Colors.black54,
                                                        offset: Offset(
                                                          0.0,
                                                          3.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 4),
                                                  child: const Text(
                                                    "°C",
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      shadows: [
                                                        Shadow(
                                                          blurRadius: 5.0,
                                                          color: Colors.black54,
                                                          offset: Offset(
                                                            2.0,
                                                            2.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 80,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        color: const Color.fromRGBO(170, 165, 165, 0.5),
                        child: const Center(
                          child: Text(
                            "Add New Location",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

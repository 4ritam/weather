
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyForecastItem extends StatelessWidget {
  final DateTime day;
  final String icon;
  final double temperature;
  final double wind;
  const DailyForecastItem({
    Key? key,
    required this.day,
    required this.icon,
    required this.temperature,
    required this.wind,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(DateFormat("E d").format(day)),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              icon,
              height: 48,
            )),
        Text(
          "$temperature°",
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$wind\nkm/h",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}

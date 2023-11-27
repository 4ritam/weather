import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final BuildContext context;
  final String info;
  final String data;
  final IconData icon;
  const AdditionalInfoItem({
    Key? key,
    required this.info,
    required this.data,
    required this.icon,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 6,
      height: MediaQuery.of(context).size.width / 6,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                info.toUpperCase(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              data,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

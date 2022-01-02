import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final double longitude;
  final double latitude;
  final String city;

  const LocationView(
      {Key? key,
      required this.longitude,
      required this.latitude,
      required this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(city.toUpperCase(),
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.white, size: 15),
            const SizedBox(width: 10),
            Text(
              longitude.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const Text(
              ' , ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Text(
              latitude.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        )
      ]),
    );
  }
}

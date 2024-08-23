import 'package:flutter/material.dart';

class DistanceTicket extends StatelessWidget {
  const DistanceTicket({Key? key, required this.distance}) : super(key: key);

  /// The distance of the profile's user
  final double distance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffecf4fc),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              "${distance.toStringAsFixed(1)} Km",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

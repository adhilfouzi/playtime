import 'package:flutter/material.dart';

import '../../../../widget/const/colors.dart';

class TurfInfo extends StatelessWidget {
  final dynamic turf;
  final String opening;
  final String close;

  const TurfInfo({
    super.key,
    required this.turf,
    required this.opening,
    required this.close,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          turf.courtName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.location_on, color: CustomColor.mainColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                turf.courtLocation,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.access_time, color: CustomColor.mainColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                turf.is24h ? "Open 24 Hours" : '$opening to $close',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

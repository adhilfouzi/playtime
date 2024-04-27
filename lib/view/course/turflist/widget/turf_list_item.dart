import 'package:flutter/material.dart';
import '../../../../model/data_model/owner_model.dart';

class TurfListItem extends StatelessWidget {
  final OwnerModel turf;

  const TurfListItem({
    super.key,
    required this.turf,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.02,
      ),
      child: Card(
        elevation: 4,
        child: ListTile(
          leading: Container(
            width: width * 0.25,
            height: height * 0.1,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Text(
            turf.courtName, // Use turf name from OwnerModel
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                turf.courtLocation, // Use turf location from OwnerModel
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                '${turf.openingTime} to ${turf.closingTime}', // Use turf distance from OwnerModel
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          onTap: () {
            // Add your onTap action here
          },
        ),
      ),
    );
  }
}

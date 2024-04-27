import 'package:flutter/material.dart';
import 'package:users_side_of_turf_booking/view/course/turflist/screens/view_turf_details.dart';
import '../../../../model/data_model/owner_model.dart';

class TurfListItem extends StatelessWidget {
  final OwnerModel turf;

  const TurfListItem({
    Key? key,
    required this.turf,
  }) : super(key: key);

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
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 16 / 9, // Adjust aspect ratio as needed
                child: Image.asset(
                  "assets/image/turf_image.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          title: Text(
            turf.courtName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                turf.courtLocation,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                '${turf.openingTime} to ${turf.closingTime}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewTurfDetailsScreen(turf: turf)));
          },
        ),
      ),
    );
  }
}

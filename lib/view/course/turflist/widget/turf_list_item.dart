import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/model/controller/formater.dart';
import 'package:users_side_of_turf_booking/view/course/turflist/screens/view_turf_details.dart';
import '../../../../view_model/course/turflist_controller.dart';

class TurfListItem extends StatelessWidget {
  final String turfid;

  const TurfListItem({
    super.key,
    required this.turfid,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final TurflistController turfController = Get.find();
    final turf = turfController.viewTurf(turfid);
    var opening = Formatter.timeOfDayToString(turf!.openingTime);
    var close = Formatter.timeOfDayToString(turf.closingTime);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.02,
      ),
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: () {
            Get.to(() => ViewTurfDetailsScreen(turfid: turf.id));
          },
          child: Padding(
            padding: EdgeInsets.all(width * 0.02),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: width * 0.25,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 16 / 12, // Adjust aspect ratio as needed
                          child: turf.images.isNotEmpty
                              ? Image.network(
                                  turf.images[0],
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/image/turf_image.jpg",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            turf.courtName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            turf.courtLocation,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            turf.is24h ? "Open 24 Hours" : '$opening to $close',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            Formatter.formatCurrency(turf.price),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

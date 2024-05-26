import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../model/controller/formater.dart';
import '../../../../utils/const/image_name.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../../turflist/screens/view_turf_details.dart';

class TurfDetailCard extends StatelessWidget {
  final String turfid;
  const TurfDetailCard({super.key, required this.turfid});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final TurfController turfController = Get.find();
    final turf = turfController.viewTurf(turfid);
    var opening = Formatter.timeOfDayToString(turf!.openingTime);
    var close = Formatter.timeOfDayToString(turf.closingTime);
    return Container(
      width: width * 0.6,
      margin: EdgeInsets.symmetric(vertical: height * 0.02),
      padding: EdgeInsets.all(width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ViewTurfDetailsScreen(turfid: turf.id));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: turf.images[0],
                width: double.infinity,
                height: height * 0.2,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.white),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  ImagePath.turf,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: height * 0.003),
            Text(
              turf.courtName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: height * 0.002),
            Text(
              turf.courtLocation,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: height * 0.002),
            Text(
              turf.is24h ? "Open 24 Hours" : '$opening to $close',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              maxLines: 1,
            ),
            SizedBox(height: height * 0.002),
            Text(
              Formatter.formatCurrency(turf.price),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

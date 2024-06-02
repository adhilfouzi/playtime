import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../widget/const/image_name.dart';
import '../../../../view_model/course/ads_controller.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final AdsController adsController = Get.put(AdsController());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: SizedBox(
        width: width,
        height: height * 0.3, // Adjusted height for the images
        child: Obx(() {
          if (adsController.adsModel.value.poster.isEmpty) {
            return Container(
              color: Colors.yellowAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.6,
                    child: Image.asset(ImagePath.logo, fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Unleash Your Game, Secure Slot Reservation",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: height * 0.002),
                  const Text(
                    "Your Premier Hub for Effortless Sports Reservations",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CarouselSlider(
              options: CarouselOptions(
                height: height * 0.3,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: adsController.adsModel.value.poster.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        width: width,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: width,
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          ImagePath.logo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
        }),
      ),
    );
  }
}

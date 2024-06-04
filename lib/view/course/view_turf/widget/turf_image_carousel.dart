import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../widget/const/colors.dart';
import '../../../../widget/const/image_name.dart';

class TurfImageCarousel extends StatelessWidget {
  final dynamic turf;
  final PageController pageController;

  const TurfImageCarousel({
    super.key,
    required this.turf,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: turf.images.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: turf.images[index],
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
                );
              },
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: turf.images.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: Colors.white,
                    activeDotColor: CustomColor.mainColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

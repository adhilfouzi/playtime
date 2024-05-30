import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../utils/turf_detailcard.dart';

class TrendingSection extends StatelessWidget {
  final TurfController controller;
  const TrendingSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(height: height * 0.01),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Trending",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: height * 0.01),
        SizedBox(
          height: height * 0.4,
          child: Obx(() => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.trendingTurfs.length,
                itemBuilder: (context, index) {
                  var turf = controller.trendingTurfs.isNotEmpty
                      ? controller.trendingTurfs[index]
                      : controller.turfList[index].id;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: TurfDetailCard(
                      turfid: turf,
                    ),
                  );
                },
              )),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../utils/turf_detailcard.dart';

class FavouriteSection extends StatelessWidget {
  final TurfController controller;
  const FavouriteSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Obx(() => controller.favouriteTurfList.favourite.isNotEmpty
        ? Column(
            children: [
              SizedBox(height: height * 0.01),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Favourite",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: height * 0.4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.favouriteTurfList.favourite.length,
                  itemBuilder: (context, index) {
                    var turf = controller.favouriteTurfList.favourite[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: TurfDetailCard(
                        turfid: turf,
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : const SizedBox());
  }
}

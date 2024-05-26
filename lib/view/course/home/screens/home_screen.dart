import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/view/course/home/utils/home_appbar.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../utils/favourite_section.dart';
import '../utils/premo_banner.dart';
import '../utils/trending_section.dart';

class HomeScreen extends StatelessWidget {
  final TurfController controller = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const HomeScreenAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const PromoBanner(),
              FavouriteSection(controller: controller),
              TrendingSection(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../widget/favourite_section.dart';
import '../widget/home_appbar.dart';
import '../widget/premo_banner.dart';
import '../widget/trending_section.dart';

class HomeScreen extends StatelessWidget {
  final TurfController controller;

  const HomeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Future<void> refresh() async {
      await controller.refreshHomescreen();
    }

    return Scaffold(
      appBar: const HomeScreenAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        child: Obx(
          () {
            if (controller.isLoadingHome) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: refresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    child: Column(
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
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/controller/formater.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../../turflist/widget/turfview_appbar.dart';
import '../widget/turf_description.dart';
import '../widget/turf_image_carousel.dart';
import '../widget/turf_info.dart';
import '../widget/turf_view_bottom.dart';

class ViewTurfDetailsScreen extends StatelessWidget {
  final String turfid;

  const ViewTurfDetailsScreen({super.key, required this.turfid});

  @override
  Widget build(BuildContext context) {
    final TurfController turfController = Get.find();
    final turf = turfController.viewTurf(turfid);
    final PageController pageController = PageController();
    final opening = Formatter.timeOfDayToString(turf!.openingTime);
    final close = Formatter.timeOfDayToString(turf.closingTime);

    return Scaffold(
      appBar: TurfViewAppBar(turfid: turfid),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TurfImageCarousel(turf: turf, pageController: pageController),
            const SizedBox(height: 20),
            TurfInfo(turf: turf, opening: opening, close: close),
            const SizedBox(height: 16),
            TurfDescription(description: turf.courtDescription),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: TurfBottomBar(turf: turf),
    );
  }
}

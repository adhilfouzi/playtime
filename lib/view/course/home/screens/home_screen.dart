import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/utils/const/image_name.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../utils/home_appbar.dart';
import '../utils/turf_detailcard.dart';

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
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  color: Colors.yellowAccent,
                  width: width,
                  height: height * 0.2,
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
                ),
              ),
              Obx(() => controller.favouriteTurfList.favourite.isNotEmpty
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
                            itemCount:
                                controller.favouriteTurfList.favourite.length,
                            itemBuilder: (context, index) {
                              var turf =
                                  controller.favouriteTurfList.favourite[index];

                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02),
                                child: TurfDetailCard(
                                  turfid: turf,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const SizedBox()),
              Column(
                children: [
                  SizedBox(height: height * 0.01),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Treading",
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: TurfDetailCard(
                                turfid: turf,
                              ),
                            );
                          },
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

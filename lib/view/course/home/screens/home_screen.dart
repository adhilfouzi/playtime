import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/utils/const/image_name.dart';
import '../../../../model/controller/formater.dart';
import '../../../../view_model/course/turflist_controller.dart';
import '../../turflist/screens/view_turf_details.dart';
import '../utils/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final TurflistController controller = Get.find();

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
                  itemCount: controller.turfList.length,
                  itemBuilder: (context, index) {
                    var turf = controller.turfList[index];

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: TurfDetailCard(
                        turfid: turf.id,
                      ),
                    );
                  },
                ),
              ),
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.turfList.length,
                  itemBuilder: (context, index) {
                    var turf = controller.turfList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: TurfDetailCard(
                        turfid: turf.id,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TurfDetailCard extends StatelessWidget {
  final String turfid;
  const TurfDetailCard({super.key, required this.turfid});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final TurflistController turfController = Get.find();
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
              child: Image.asset(
                "assets/image/turf_image.jpg",
                width: double.infinity,
                height: height * 0.2,
                fit: BoxFit.cover,
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

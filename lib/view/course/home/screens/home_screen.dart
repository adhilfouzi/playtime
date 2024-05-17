import 'package:flutter/material.dart';
import 'package:users_side_of_turf_booking/utils/const/image_name.dart';
import '../utils/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const HomeScreenAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: const TurfDetailCard(),
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: const TurfDetailCard(),
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
  const TurfDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
          const Text(
            'Gamma Football',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: height * 0.002),
          const Text(
            'Chilavannoor, Ernakulam',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: height * 0.002),
          const Text(
            '05:00 AM to 02:00 AM',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: height * 0.002),
          const Text(
            "Rs: 1000",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

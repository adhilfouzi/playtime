import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:users_side_of_turf_booking/widget/appbar/titleonly_appbar.dart';
import 'package:users_side_of_turf_booking/widget/const/image_name.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const TitleOnlyAppBar(
        title: 'About Us',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: width * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.2),
              // Centered logo with appropriate size
              Image.asset(
                ImagePath.logo,
                height: height * 0.2,
              ),
              SizedBox(height: height * 0.2),

              // App description with improved text styling
              const Text(
                'Welcome to Our App!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: height * 0.05),

              // Version info with clear styling
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Version ${snapshot.data!.version}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    );
                  } else {
                    return Text('Version Loading...',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

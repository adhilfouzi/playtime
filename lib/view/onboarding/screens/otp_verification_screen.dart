// import 'package:flutter/material.dart';
// import 'package:turf_booking_application_for_user/model/controller/appbar.dart';
// import 'package:turf_booking_application_for_user/model/controller/button.dart';

// import '../model/const/image_name.dart';

// class OtpVerificationScreen extends StatelessWidget {
//   const OtpVerificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return SafeArea(
//         child: Scaffold(
//       appBar: IntroAppbar(
//         actions: const [],
//         titleText: 'Enter Code',
//         leading: () {},
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: height * 0.25,
//               width: width,
//               child: Image.asset(logo),
//             ),
//             const Text(
//               'Enter the OTP sent to your gmail \nalex12@gmail.com',
//               style: TextStyle(fontSize: 13),
//             ),
//             SizedBox(height: height * 0.06),
//             Button().mainButton('Verify', context, () {}),
//           ],
//         ),
//       ),
//     ));
//   }
// }

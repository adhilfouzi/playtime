// import 'package:flutter/material.dart';
// import '../utils/appbar.dart';
// import '../../../utils/portion/button.dart';
// import '../../../utils/portion/textfield.dart';
// import '../../../utils/const/image_name.dart';
// import 'login_screen.dart';

// class PasswordVerifyonSignup extends StatelessWidget {
//   PasswordVerifyonSignup({super.key});
//   final passwordTextEditingController = TextEditingController();
//   final rePasswordTextEditingController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     return SafeArea(
//       child: Scaffold(
//         appBar: const IntroAppbar(
//           actions: [],
//           titleText: 'Create Password',
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               SizedBox(
//                 height: height * 0.25,
//                 width: width,
//                 child: Image.asset(ImagePath.logo),
//               ),
//               const Text('Create Password'),
//               SizedBox(height: height * 0.05),
//               PasswordTextField(
//                 textInputAction: TextInputAction.next,
//                 hintText: 'Enter Password',
//                 keyboardType: TextInputType.visiblePassword,
//                 controller: passwordTextEditingController,
//               ),
//               PasswordTextField(
//                 textInputAction: TextInputAction.done,
//                 keyboardType: TextInputType.visiblePassword,
//                 controller: rePasswordTextEditingController,
//                 hintText: 'Confirm Password',
//               ),
//               SizedBox(
//                 width: width * 0.9,
//                 child: const Text(
//                   "Password must be at least 8 character long and include 1 capital letter and 1 symbol",
//                   style: TextStyle(fontSize: 12),
//                 ),
//               ),
//               SizedBox(height: height * 0.2),
//               Button().mainButton('Verify', context, () {
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => LoginScreen()));
//               }),
//               SizedBox(height: height * 0.04),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

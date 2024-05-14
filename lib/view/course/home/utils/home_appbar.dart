import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/view_model/course/usermodel_controller.dart';

import '../../../../utils/const/icons_image.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find();
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          AppIconConverter.fromAsset(
            AppIcons.handWave,
            height: 30,
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello ${controller.user.value.name}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Be the best version of yourself',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        InkWell(
          child: SvgPicture.asset(AppIcons.notification),
          onTap: () {
            // Handle notification button press
          },
        ),
        SizedBox(
          width: MediaQuery.of(context).size.height * 0.021,
        )
      ],
    );
  }
}

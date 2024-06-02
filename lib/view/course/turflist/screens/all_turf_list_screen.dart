import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../../head/bottom_navigationbar_widget.dart';
import '../widget/search_field.dart';
import '../widget/turflist.dart';

class AllTurfList extends StatelessWidget {
  final TurfController controller;

  const AllTurfList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        Get.offAll(fullscreenDialog: true, const MyBottomNavigationBar());
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: SearchField(
            controller: controller,
          ),
          actions: const [
            // FilterButton(),
          ],
        ),
        body: TurfListscreen(
          controller: controller,
        ),
      ),
    );
  }
}

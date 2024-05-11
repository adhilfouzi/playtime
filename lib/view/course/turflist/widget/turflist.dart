import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../view_model/course/turflist_controller.dart';
import 'turf_list_item.dart';

class TurfListscreen extends StatelessWidget {
  final TurflistController controller;
  const TurfListscreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.errorMessage.isNotEmpty) {
        return Center(
          child: Text(controller.errorMessage),
        );
      } else {
        final turfList = controller.turfList;
        return ListView.builder(
          itemCount: turfList.length,
          itemBuilder: (context, index) {
            return TurfListItem(turf: turfList[index]);
          },
        );
      }
    });
  }
}

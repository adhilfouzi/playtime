import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../view_model/course/turflist_controller.dart';
import 'turf_list_item.dart';

class TurfListscreen extends StatelessWidget {
  final TurflistController controller;
  const TurfListscreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Future<void> refresh() async {
      await controller.searchTurf();
    }

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
        if (turfList.isEmpty) {
          return RefreshIndicator(
            onRefresh: refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height - 200,
                alignment: Alignment.center,
                child: const Text("No bookings are available"),
              ),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
              itemCount: turfList.length,
              itemBuilder: (context, index) {
                return TurfListItem(turf: turfList[index]);
              },
            ),
          );
        }
      }
    });
  }
}

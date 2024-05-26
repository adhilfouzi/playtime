import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../view_model/course/turf_controller.dart';
import '../widget/search_field.dart';
import '../widget/turflist.dart';

class AllTurfList extends StatelessWidget {
  final TurfController controller = Get.find();

  AllTurfList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

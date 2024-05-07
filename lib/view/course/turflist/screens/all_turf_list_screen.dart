import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/turflist_controller.dart';
import '../widget/search_field.dart';
import '../widget/turflist.dart';

class AllTurfList extends StatelessWidget {
  final TurflistController controller = Get.put(TurflistController());

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

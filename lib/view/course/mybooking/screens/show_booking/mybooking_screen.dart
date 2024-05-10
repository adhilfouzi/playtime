import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_side_of_turf_booking/view/course/mybooking/screens/show_booking/active_booking.dart';
import 'package:users_side_of_turf_booking/view/course/mybooking/screens/show_booking/canceled_booking.dart';
import 'package:users_side_of_turf_booking/view/course/mybooking/screens/show_booking/completed_booking.dart';

import '../../controller/bookings_controller.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> with TickerProviderStateMixin {
  final BookingsController controller = Get.put(BookingsController());
  late TabController tabController;
  List<String> tabTitles = ['Active', 'Canceled', 'Completed'];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      tabTitles = ['Active', 'Canceled', 'Completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Booking",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, height * 0.06),
          child: Column(
            children: [
              CustomTabBar(
                controller: tabController,
                onTabChanged: (index) {
                  tabController.animateTo(index);
                },
                tabTitles: tabTitles,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: TabBarView(
          controller: tabController,
          children: [
            Hero(tag: 'Active', child: ActiveBooking(controller: controller)),
            Hero(
                tag: 'Canceled',
                child: CanceledBooking(controller: controller)),
            Hero(
                tag: 'Completed',
                child: CompletedBooking(controller: controller)),
          ],
        ),
      ),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  final TabController controller;
  final Function(int) onTabChanged;
  final List<String> tabTitles;

  const CustomTabBar({
    required this.controller,
    required this.onTabChanged,
    required this.tabTitles,
    super.key,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return TabBar(
      controller: widget.controller,
      tabs: widget.tabTitles.map((title) {
        return Tab(
          child: Container(
            width: width * 0.5,
            // height: height * 0.1,
            decoration: BoxDecoration(
              color: title == widget.tabTitles[widget.controller.index]
                  ? const Color(0xFF238C98)
                  : Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: const Color(0xFF238C98),
              ),
            ),
            padding: EdgeInsets.symmetric(
                vertical: height * 0.008, horizontal: width * 0.002),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: title == widget.tabTitles[widget.controller.index]
                    ? Colors.white
                    : const Color(0xFF238C98),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
      unselectedLabelColor: Colors.black45,
      labelColor: Colors.black,
      dividerColor: Colors.transparent,
      indicator: const BoxDecoration(
        color: Colors.transparent,
      ),
      onTap: widget.onTabChanged,
    );
  }
}

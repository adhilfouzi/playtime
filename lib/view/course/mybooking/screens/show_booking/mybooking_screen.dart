import 'package:flutter/material.dart';

import 'active_booking.dart';
import 'canceled_booking.dart';
import 'completed_booking.dart';
import 'utils/tab_bar.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> with TickerProviderStateMixin {
  late TabController tabController;
  List<String> tabTitles = ['Active', 'Completed', 'Canceled'];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      tabTitles = ['Active', 'Completed', 'Canceled'];
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
          children: const [
            Hero(tag: 'Active', child: ActiveBooking()),
            Hero(tag: 'Completed', child: CompletedBooking()),
            Hero(tag: 'Canceled', child: CanceledBooking()),
          ],
        ),
      ),
    );
  }
}

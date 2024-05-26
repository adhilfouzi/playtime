import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../utils/const/icons_image.dart';
import '../../../view_model/course/turf_controller.dart';
import '../../../view_model/course/usermodel_controller.dart';
import '../home/screens/home_screen.dart';
import '../mybooking/screens/show_booking/mybooking_screen.dart';
import '../profile/screens/userprofle_screen.dart';
import '../turflist/screens/all_turf_list_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AllTurfList(),
    const MyBooking(),
    const UserProfile(),
  ];
  final TurfController turf = Get.find();
  final UserController user = Get.find();
  @override
  void initState() {
    super.initState();
    turf.fetchTurfList();
    turf.separateBookings();
    user.getUserRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black12,
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTapped,
              tabs: [
                _buildGButton(
                  index: 0,
                  selectedIcon: AppIcons.home,
                  nonSelectedIcon: AppIcons.homeOutlined,
                  label: 'Home',
                ),
                _buildGButton(
                  index: 1,
                  selectedIcon: AppIcons.football,
                  nonSelectedIcon: AppIcons.footballOutlined,
                  label: 'Spot',
                ),
                _buildGButton(
                  index: 2,
                  selectedIcon: AppIcons.newspaper,
                  nonSelectedIcon: AppIcons.newspaperOutlined,
                  label: 'My Slot',
                ),
                _buildGButton(
                  index: 3,
                  selectedIcon: AppIcons.user,
                  nonSelectedIcon: AppIcons.userOutlined,
                  label: 'Profile',
                ),
              ],
              gap: 4,
              color: Colors.grey[800]!,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 800),
              tabBackgroundColor: Colors.grey[100]!,
              // tabBorderRadius: 20,
            ),
          ),
        ),
      ),
    );
  }

  GButton _buildGButton({
    required String selectedIcon,
    required String nonSelectedIcon,
    required String label,
    required int index,
  }) {
    bool isSelected = index == _selectedIndex;
    return GButton(
      icon: Icons.abc,
      leading: SvgPicture.asset(
        isSelected ? selectedIcon : nonSelectedIcon,
        width: 24,
        height: 24,
        color: Colors.black,
      ),
      text: label,
      textColor: Colors.black,
      backgroundColor: Colors.transparent,
      hoverColor: Colors.transparent,
      rippleColor: Colors.transparent,
      border: isSelected
          ? Border.all(color: Colors.black, width: 2)
          : Border.all(color: Colors.transparent),
      onPressed: isSelected ? null : () => _onItemTapped(index),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

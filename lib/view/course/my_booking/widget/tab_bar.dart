import 'package:flutter/material.dart';

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

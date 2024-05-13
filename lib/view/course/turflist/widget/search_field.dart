import 'package:flutter/material.dart';

import '../../../../view_model/course/turflist_controller.dart';

class SearchField extends StatelessWidget {
  final TurflistController controller;
  const SearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.0002,
        horizontal: width * 0.002,
      ),
      child: TextFormField(
        decoration: const InputDecoration(
            hintText: 'Search Turf ....',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none),
        onChanged: (query) {
          controller.query.value = query;
          controller.searchTurf();
        },
      ),
    );
  }
}

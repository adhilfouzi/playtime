import 'package:flutter/material.dart';

import '../widget/filter_button.dart';
import '../widget/search_field.dart';
import '../widget/turf_list_item.dart';

class AllTurfList extends StatelessWidget {
  const AllTurfList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchField(),
        actions: const [
          FilterButton(),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with your actual list length
        itemBuilder: (context, index) {
          return TurfListItem(index: index);
        },
      ),
    );
  }
}

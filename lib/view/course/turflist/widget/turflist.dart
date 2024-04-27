import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../view_model/bloc/turflist/turflist_bloc.dart';
import 'turf_list_item.dart';

class TurfListscreen extends StatelessWidget {
  const TurfListscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TurflistBloc, TurflistState>(
      builder: (context, state) {
        if (state is TurfInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TurfLoaded) {
          final turfList = state.turfList;

          // Build your UI with the turfList
          return ListView.builder(
            itemCount: turfList.length, // Replace with your actual list length
            itemBuilder: (context, index) {
              return TurfListItem(turf: turfList[index]);
            },
          );
        } else if (state is TurfError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container(); // Handle other states if needed
        }
      },
    );
  }
}

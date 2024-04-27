import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_side_of_turf_booking/view/course/turflist/widget/turflist.dart';
import 'package:users_side_of_turf_booking/view_model/bloc/turflist/turflist_bloc.dart';

import '../widget/filter_button.dart';
import '../widget/search_field.dart';

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
      body: BlocProvider(
          create: (context) => TurflistBloc()..add(FetchTurfList()),
          child: const TurfListscreen()),
    );
  }
}

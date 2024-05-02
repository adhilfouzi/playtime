import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../view_model/bloc/turflist/turflist_bloc.dart';
import '../widget/search_field.dart';
import '../widget/turflist.dart';

class AllTurfList extends StatelessWidget {
  const AllTurfList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const SearchField(),
        actions: const [
          // FilterButton(),
        ],
      ),
      body: BlocProvider(
          create: (context) => TurflistBloc()..add(FetchTurfList()),
          child: const TurfListscreen()),
    );
  }
}

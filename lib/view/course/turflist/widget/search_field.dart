import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../view_model/bloc/turflist/turflist_bloc.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

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
          BlocProvider.of<TurflistBloc>(context).add(SearchTurf(query));
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/backend/repositories/firestore/turf_repositories.dart';
import '../../../model/data_model/owner_model.dart';

part 'turflist_event.dart';
part 'turflist_state.dart';

class TurflistBloc extends Bloc<TurflistEvent, TurflistState> {
  TurflistBloc() : super(TurfInitial()) {
    on<FetchTurfList>(onFetchTurfList);
    on<SearchTurf>(onSearchTurf);
  }
  void onFetchTurfList(event, emit) async {
    emit(TurfLoading());
    try {
      var turfList = await TurfRepository().fetchAllTurfDetails();
      emit(TurfLoaded(turfList));
    } catch (e) {
      emit(TurfError('Failed to fetch turf list: $e'));
    }
  }

  void onSearchTurf(SearchTurf event, Emitter<TurflistState> emit) async {
    emit(TurfLoading());
    try {
      var searchedTurfList = await TurfRepository().searchTurf(event.query);
      emit(TurfLoaded(searchedTurfList));
    } catch (e) {
      emit(TurfError('Failed to search turf list: $e'));
    }
  }
}

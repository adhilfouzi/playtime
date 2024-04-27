part of 'turflist_bloc.dart';

@immutable
sealed class TurflistState {}

// Define the states for the TurfBloc

class TurfInitial extends TurflistState {}

class TurfLoading extends TurflistState {}

class TurfSearching extends TurflistState {}

class TurfLoaded extends TurflistState {
  final List<OwnerModel> turfList;

  TurfLoaded(this.turfList);
}

class TurfError extends TurflistState {
  final String message;

  TurfError(this.message);
}

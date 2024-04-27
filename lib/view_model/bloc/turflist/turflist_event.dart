part of 'turflist_bloc.dart';

@immutable
sealed class TurflistEvent {}

class FetchTurfList extends TurflistEvent {}

class SearchTurf extends TurflistEvent {
  final String query;

  SearchTurf(this.query);
}

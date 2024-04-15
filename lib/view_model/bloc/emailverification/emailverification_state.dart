part of 'emailverification_bloc.dart';

@immutable
sealed class EmailVerificationState {}

final class EmailverificationInitial extends EmailVerificationState {}

final class EmailVerificationLoading extends EmailVerificationState {}

final class EmailVerificationSuccess extends EmailVerificationState {}

final class EmailVerificationError extends EmailVerificationState {
  final String error;
  EmailVerificationError({required this.error});
}

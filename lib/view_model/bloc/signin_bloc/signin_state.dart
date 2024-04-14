part of 'signin_bloc.dart';

@immutable
sealed class SigninState {}

final class SigninInitial extends SigninState {}

final class SigninLoading extends SigninState {}

final class SigninSuccess extends SigninState {}

final class SigninError extends SigninState {
  final String error;
  SigninError({required this.error});
}

final class SignOutSuccess extends SigninState {}

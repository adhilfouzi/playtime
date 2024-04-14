part of 'signin_bloc.dart';

@immutable
sealed class SigninEvent {}

final class SigninRequested extends SigninEvent {
  final String email;
  final String password;

  SigninRequested({required this.email, required this.password});
}

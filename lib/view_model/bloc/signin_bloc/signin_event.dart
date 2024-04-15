part of 'signin_bloc.dart';

@immutable
sealed class SigninEvent {}

final class SigninRequested extends SigninEvent {
  final String email;
  final String password;
  final BuildContext context;

  SigninRequested(
      {required this.context, required this.email, required this.password});
}

part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

final class SignupRequested extends SignupEvent {
  final UserModel user;
  final BuildContext context;
  final String password;

  SignupRequested({
    required this.context,
    required this.user,
    required this.password,
  });
}

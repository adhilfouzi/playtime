part of 'emailverification_bloc.dart';

@immutable
sealed class EmailVerificationEvent {}

final class EmailVerificationRequested extends EmailVerificationEvent {
  final String email;
  final BuildContext context;

  EmailVerificationRequested({
    required this.context,
    required this.email,
  });
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../model/backend/repositories/authentication/firebase_authentication.dart';
// import '../../../utils/portion/loadingpopup.dart';
// part 'emailverification_event.dart';
// part 'emailverification_state.dart';

// class EmailVerificationBloc
//     extends Bloc<EmailVerificationEvent, EmailVerificationState> {
//   EmailVerificationBloc() : super(EmailverificationInitial()) {
//     on<EmailVerificationRequested>(onEmailVerificationRequested);
//   }
//   void onEmailVerificationRequested(EmailVerificationRequested event,
//       Emitter<EmailVerificationState> emit) async {
//     emit(EmailVerificationLoading());
//     Navigator.of(event.context)
//         .push(MaterialPageRoute(builder: (context) => const LoadingPopup()));
//     await AuthenticationRepository().sendPasswordResetEmail(event.email);
//     emit(EmailVerificationSuccess());
//     try {} catch (e) {
//       emit(EmailVerificationError(error: e.toString()));
//     }
//   }
// }

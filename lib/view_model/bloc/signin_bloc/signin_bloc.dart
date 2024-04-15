import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/backend/repositories/authentication/firebase_authentication.dart';
import '../../../utils/portion/loadingpopup.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<SigninRequested>(onSigninRequested);
  }
  void onSigninRequested(
      SigninRequested event, Emitter<SigninState> emit) async {
    emit(SigninLoading());
    try {
      Navigator.of(event.context)
          .push(MaterialPageRoute(builder: (context) => const LoadingPopup()));
      bool isUser = await AuthenticationRepository()
          .signInWithEmailAndPassword(event.email, event.password);
      if (isUser) {
        emit(SigninSuccess());
      } else {
        log("Some error happened");
      }
    } catch (e) {
      emit(SigninError(error: e.toString()));
    }
  }
}

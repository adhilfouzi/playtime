import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/backend/repositories/authentication/firebase_authentication.dart';

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
      User? user = await AuthenticationRepository()
          .signInWithEmailAndPassword(event.email, event.password);
      if (user != null) {
        emit(SigninSuccess());
      } else {
        print("Some error happened");
      }
    } catch (e) {
      emit(SigninError(
          error: "Something went wrong. Please try again.\n ${e.toString()}"));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class CheckboxCubit extends Cubit<bool> {
  CheckboxCubit() : super(false); // Initialize with false value

  // Method to toggle the checkbox state
  void privacyPolicyChecked(bool newValue) {
    emit(newValue);
  }
}

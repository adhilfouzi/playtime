import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data_model/user_model.dart';
import '../authentication/firebase_exceptionhandler.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///  function to save user data to Firestore
  Future<void> saveUserRecord(UserModel user, id) async {
    try {
      await _db.collection("Users").doc(id).set(user.toJson());
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}

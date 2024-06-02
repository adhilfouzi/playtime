import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepository {
  /// Upload an image to Firebase Storage and return the download URL
  static Future<String> uploadImage(File file) async {
    try {
      // Get the current user's ID from Firebase Authentication
      final userId = FirebaseAuth.instance.currentUser!.uid;

      // Extract the file name from the file path
      final fileName = file.path.split("/").last;

      // Get the current timestamp to ensure unique file names
      final time = DateTime.now().millisecondsSinceEpoch;

      // Create a reference to the location in Firebase Storage where the file will be uploaded
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('user_profile/$userId/$time-$fileName');

      // Start the file upload to Firebase Storage
      UploadTask uploadTask = reference.putFile(file);

      // Wait for the upload to complete and get the TaskSnapshot
      TaskSnapshot taskSnapshot = await uploadTask;

      // Retrieve the download URL of the uploaded file
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Return the download URL
      return imageUrl;
    } catch (e) {
      // Handle any exceptions that occur during the upload process
      throw Exception('Failed to upload image to Firebase Storage: $e');
    }
  }
}

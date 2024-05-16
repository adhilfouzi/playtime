import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/backend/repositories/firestore/profile_image_repository.dart';
import '../../model/backend/repositories/firestore/user_repositories.dart';
import '../../utils/portion/snackbar.dart';
import 'usermodel_controller.dart';

class ImageController extends GetxController {
  Rx<File?> imageProfile = Rx<File?>(null);
  Rx<String?> imagePath = ''.obs;

  final UserController user = Get.find();

  Future<void> getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      } else {
        // final croppedFile = image;
        imageProfile.value = File(image.path);
        await uploadProfileImage();
        imagePath = Rx<String?>(image.path);
      }
    } catch (e) {
      log('Failed image picker: $e');
    }
  }

  Future<void> uploadProfileImage() async {
    try {
      if (imageProfile.value != null) {
        final imageUrl =
            await ProfileRepository.uploadImage(imageProfile.value!);
        imagePath.value = imageUrl;
        log(imageUrl);
        await UserRepository()
            .updateSpecificField(fieldName: 'profile', value: imageUrl);
        log("update Specific Field");
        await user.getUserRecord();
        CustomSnackbar.showSuccess('Profile image uploaded successfully');
      } else {
        log("imageProfile is null");
      }
    } catch (e) {
      log('Error uploading profile image: $e');
      CustomSnackbar.showError('Failed to upload profile image');
    }
  }

  void openDialog() {
    Get.defaultDialog(
      title: '',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Choose Image From.......',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                  Get.back();
                },
                icon: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                  Get.back();
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

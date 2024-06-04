import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../view_model/course/usermodel_controller.dart';
import 'editable_field.dart';

class UserDetails extends StatelessWidget {
  final UserController user;
  final double screenHeight;

  const UserDetails({
    super.key,
    required this.user,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(
        () => Column(
          children: [
            EditableField(
              label: 'Name',
              value: user.user.value.name,
              onEdit: () => user.editUserDetail('Name'),
            ),
            SizedBox(height: screenHeight * 0.02),
            EditableField(
              label: 'Number',
              value: user.user.value.number,
              onEdit: () => user.editUserDetail('Number'),
            ),
          ],
        ),
      ),
    );
  }
}

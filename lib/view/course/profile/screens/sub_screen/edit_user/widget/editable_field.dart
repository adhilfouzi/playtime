import 'package:flutter/material.dart';

import '../../../../../../../widget/const/colors.dart';

class EditableField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onEdit;

  const EditableField({
    super.key,
    required this.label,
    required this.value,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        IconButton(
          onPressed: onEdit,
          icon: const Icon(Icons.edit, color: CustomColor.mainColor),
        ),
      ],
    );
  }
}

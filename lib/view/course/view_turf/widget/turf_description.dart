import 'package:flutter/material.dart';

class TurfDescription extends StatelessWidget {
  final String description;

  const TurfDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(fontSize: 16),
    );
  }
}

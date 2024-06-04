import 'package:flutter/material.dart';

import '../../../model/controller/formater.dart';

class TotalPriceDisplay extends StatelessWidget {
  final double price;

  const TotalPriceDisplay({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Total Price: ${Formatter.formatCurrency(price)}",
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

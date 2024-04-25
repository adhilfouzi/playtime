import 'package:flutter/material.dart';

class TurfListItem extends StatelessWidget {
  final int index;

  const TurfListItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.02,
      ),
      child: Card(
        elevation: 4,
        child: ListTile(
          leading: Container(
            width: width * 0.25,
            height: height * 0.1,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: const Text(
            'MTM Sports', // Replace with turf name
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ponnani, Malappuram', // Replace with turf place
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$index km', // Replace with distance
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          onTap: () {
            // Add your onTap action here
          },
        ),
      ),
    );
  }
}

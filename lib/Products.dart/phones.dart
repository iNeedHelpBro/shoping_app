import 'package:flutter/material.dart';

class Phones extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final Color backgroundColor;
  const Phones({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 5),
          Text(
            'PHP$price',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 25),
          Expanded(
            flex: 3,
            child: Center(
              child: Image.asset(
                image,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

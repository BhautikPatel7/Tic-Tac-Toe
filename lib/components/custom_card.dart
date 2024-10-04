import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String content;

  CustomCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium, // Title Color changes with theme
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge, // Body Text Color changes with theme
            ),
          ],
        ),
      ),
    );
  }
}

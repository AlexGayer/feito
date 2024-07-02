import 'package:flutter/material.dart';

class TypeTodoIconWidget extends StatelessWidget {
  final IconData icon;
  const TypeTodoIconWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          size: 40,
        ),
      ),
    );
  }
}

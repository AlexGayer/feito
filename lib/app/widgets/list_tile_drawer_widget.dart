import 'package:flutter/material.dart';

class ListTileDrawerWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  final IconData icon;
  const ListTileDrawerWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.grey.withOpacity(0.1),
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      onTap: onTap,
    );
  }
}

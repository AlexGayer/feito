import 'package:feito/app/global/dialog_helper.dart';
import 'package:flutter/material.dart';

class CardTaskWidget extends StatelessWidget {
  final String name;
  final String descripion;
  final String date;
  final Color color;
  final String id;
  final Function onDelete;

  const CardTaskWidget({
    super.key,
    required this.name,
    required this.descripion,
    required this.date,
    required this.color,
    required this.id,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        final confirmed =
            await DialogHelper.showDeleteConfirmationDialog(context, name);
        if (confirmed ?? false) {
          onDelete();
          return true;
        }
        return null;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 2)),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 15, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 10),
                  Text(descripion,
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 10),
                  Text(date, style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 10),
                ],
              ),
            )),
      ),
    );
  }
}

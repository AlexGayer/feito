import 'package:feito/app/global/dialog_helper.dart';
import 'package:flutter/material.dart';

class CardTaskWidget extends StatelessWidget {
  final String name;
  final String descripion;
  final String date;
  final String time;
  final Color color;
  final String id;
  final Function onDelete;

  const CardTaskWidget({
    super.key,
    required this.name,
    required this.descripion,
    required this.date,
    required this.time,
    required this.color,
    required this.id,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      background: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 10),
                    Text(descripion,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 10),
                    Text(date, style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 10),
                    Text(time, style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

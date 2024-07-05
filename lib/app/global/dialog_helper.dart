import 'package:flutter/material.dart';

class DialogHelper {
  static Future<bool?> showDeleteConfirmationDialog(
    BuildContext context,
    String taskName,
  ) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar Exclusão",
              style: Theme.of(context).textTheme.displayLarge),
          content: Text("Tem certeza que deseja excluir a tarefa '$taskName'?",
              style: Theme.of(context).textTheme.displayMedium),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancelar",
                  style: Theme.of(context).textTheme.displaySmall),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                "Excluir",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
    Function() confirmed,
  ) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: Theme.of(context).textTheme.displayLarge),
          content:
              Text(content, style: Theme.of(context).textTheme.displayMedium),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancelar",
                  style: Theme.of(context).textTheme.displayMedium),
            ),
            TextButton(
              onPressed: confirmed,
              child: Text(
                "OK",
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }
}

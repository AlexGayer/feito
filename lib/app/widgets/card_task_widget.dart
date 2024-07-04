import 'package:feito/app/controller/schedule_controller.dart';
import 'package:feito/app/global/dialog_helper.dart';
import 'package:feito/app/global/widget_stateful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardTaskWidget extends StatefulWidget {
  final String name;
  final String descripion;
  final String date;
  final String time;
  final Color color;
  final String id;
  final Function onDelete;
  final Function onEdit;
  final Function onComplete;

  const CardTaskWidget({
    super.key,
    required this.name,
    required this.descripion,
    required this.date,
    required this.time,
    required this.color,
    required this.id,
    required this.onDelete,
    required this.onEdit,
    required this.onComplete,
  });

  @override
  State<CardTaskWidget> createState() => _CardTaskWidgetState();
}

class _CardTaskWidgetState
    extends WidgetStateful<CardTaskWidget, ScheduleController> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      background: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20.0),
          child: const Icon(Icons.edit, color: Colors.white),
        ),
      ),
      secondaryBackground: Padding(
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
        if (direction == DismissDirection.startToEnd) {
          final result = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              TextEditingController nameController =
                  TextEditingController(text: widget.name);
              TextEditingController descriptionController =
                  TextEditingController(text: widget.descripion);
              return EditDialogWidget(
                  nameController: nameController,
                  descriptionController: descriptionController,
                  onEdit: widget.onEdit,
                  id: widget.id);
            },
          );
          return result ?? false;
        } else if (direction == DismissDirection.endToStart) {
          final confirmed = await DialogHelper.showDeleteConfirmationDialog(
              context, widget.name);
          if (confirmed ?? false) {
            widget.onDelete();
            return true;
          }
          return false;
        }
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: widget.color,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.name,
                            style:
                                TextStyle(color: widget.color, fontSize: 18)),
                        Observer(
                          builder: (_) => IconButton(
                            onPressed: () =>
                                controller.toggleComplete(context, widget.id),
                            icon: Icon(
                              MdiIcons.check,
                              color: controller.isCompleted
                                  ? Colors.green
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(widget.descripion,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 10),
                    Text(widget.date,
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 10),
                    Text(widget.time,
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class EditDialogWidget extends StatelessWidget {
  const EditDialogWidget({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.onEdit,
    required this.id,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final Function onEdit;
  final String id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Tarefa'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text('Salvar'),
          onPressed: () {
            onEdit(id, nameController.text, descriptionController.text);
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}

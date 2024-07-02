import 'dart:math';
import 'package:feito/app/domain/model/task.dart';
import 'package:feito/app/widgets/task_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'schedule_controller.g.dart';

@injectable
class ScheduleController = _ScheduleControllerBase with _$ScheduleController;

abstract class _ScheduleControllerBase with Store {
  final customDialog = const TaskDialogWidget();

  final tarefaCtrl = TextEditingController();
  final descrCtrl = TextEditingController();
  final timeCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime(2024);
  DateTime lastDate = DateTime(2999);

  Random random = Random();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  _ScheduleControllerBase();

  @observable
  bool _isOpened = false;

  @observable
  bool _loading = false;

  @observable
  Color? color;

  @computed
  bool get isOpened => _isOpened;

  @computed
  bool get loading => _loading;

  @observable
  List<Task> taskList = [];

  @action
  initState() async {
    try {
      _loading = true;
      await fetchTasks();
    } finally {
      _loading = false;
    }
  }

  @action
  Future<void> addTask(BuildContext context) async {
    _loading = true;
    try {
      if (formKey.currentState != null) {
        if (formKey.currentState!.validate()) {
          final task = Task(
            id: '', // O Firestore irá gerar um ID automaticamente
            name: tarefaCtrl.text,
            description: descrCtrl.text,
            date: toBRDt(selectedDate),
            time: toBRDHr(timeOfDay),
          );

          // Adicionar a tarefa ao Firestore
          await firestore.collection('tasks').add(task.toJson());

          // Atualizar a lista de tarefas localmente
          await fetchTasks();

          clearTextController();
          _isOpened = false;
          _loading = false;
        }
      }
    } catch (e) {
      clearTextController();
      _isOpened = false;
      _loading = false;
    }
  }

  @action
  Future<void> fetchTasks() async {
    try {
      final querySnapshot = await firestore.collection('tasks').get();
      taskList = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Adicionar o ID do documento ao mapa de dados
        return Task.fromJson(data); // Utilize o método fromJson para converter
      }).toList();
    } catch (e) {
      print("Erro ao buscar tarefas: $e");
    }
  }

  @action
  Future<void> deleteTask(String taskId) async {
    try {
      await firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      print("Erro ao excluir tarefa: $e");
      throw e;
    }
  }

  @action
  getSchedule(BuildContext context) {
    _isOpened = true;
    return customDialog.showTaskDialog(
      context,
      tarefaCtrl,
      descrCtrl,
      timeCtrl,
      dateCtrl,
      formKey,
      () => _datePicker(context),
      () => _timePicker(context),
      () => addTask(context),
      () {
        Navigator.of(context).pop();
        clearTextController();
        _isOpened = false;
      },
    );
  }

  @action
  Future _timePicker(BuildContext context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
      cancelText: "Cancelar",
      confirmText: "Confirmar",
      builder: (context, child) => Theme(
        data: ThemeData(timePickerTheme: Theme.of(context).timePickerTheme),
        child: child!,
      ),
    );
    if (time != null) {
      timeOfDay = time;
      timeCtrl.text = toBRDHr(time);
    }
  }

  Future _datePicker(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) => Theme(
        data: ThemeData(timePickerTheme: Theme.of(context).timePickerTheme),
        child: child!,
      ),
    );

    if (datePicked != null && datePicked != selectedDate) {
      selectedDate = datePicked;
      dateCtrl.text = toBRDt(selectedDate);
    }
  }

  @action
  clearTextController() {
    tarefaCtrl.clear();
    descrCtrl.clear();
    timeCtrl.clear();
    dateCtrl.clear();
  }

  @action
  toBRDt(DateTime? date) {
    if (date != null) {
      final day = date.day.toString();
      final month = date.month.toString();
      final year = date.year.toString();
      return "${day.padLeft(2, "0")}/${month.padLeft(2, "0")}/$year";
    }
    return "";
  }

  @action
  toBRDHr(TimeOfDay? time) {
    if (time != null) {
      final hour = time.hour.toString();
      final minute = time.minute.toString();

      return "${hour.padLeft(2, "0")}:${minute.padLeft(2, "0")}";
    }
    return "";
  }
}

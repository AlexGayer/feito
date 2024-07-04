// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:math';
import 'package:feito/app/data/respository/firestore_repository.dart';
import 'package:feito/app/domain/model/task.dart';
import 'package:feito/app/global/shared_preferences_handler.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'schedule_controller.g.dart';

@injectable
class ScheduleController = _ScheduleControllerBase with _$ScheduleController;

abstract class _ScheduleControllerBase with Store {
  final FirestoreRepository _firestoreRepository;

  final tarefaCtrl = TextEditingController();
  final descrCtrl = TextEditingController();
  final timeCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final handler = SharedPreferencesHandler();

  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime(2024);
  DateTime lastDate = DateTime(2999);

  Random random = Random();

  _ScheduleControllerBase(this._firestoreRepository);

  @observable
  bool _isOpened = false;

  @observable
  bool _loading = false;

  @observable
  Color? color;

  @observable
  int index = 0;

  @observable
  String _selectedPriority = "";

  @observable
  Color priorityColor = Colors.grey;

  @computed
  bool get isOpened => _isOpened;

  @computed
  bool get loading => _loading;

  @computed
  String get selectedPriority => _selectedPriority;

  @observable
  List<Task> taskList = [];

  @observable
  List colors = [
    Colors.cyan[50],
    Colors.cyan[100],
    Colors.cyan[200],
    Colors.cyan[300],
    Colors.cyan[400],
  ];

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
            id: '',
            name: tarefaCtrl.text,
            description: descrCtrl.text,
            date: selectedDate,
            time: toBRDHr(timeOfDay),
            priority: _selectedPriority,
            isCompleted: false,
          );

          // Adicionar a tarefa ao Firestore
          await _firestoreRepository.addTask(task);
          selectedDate = DateFormat("dd/MM/yyyy").parse(dateCtrl.text);

          // Atualizar a lista de tarefas localmente
          await fetchTasks();

          clearTextController();

          _loading = false;
        }
      }
    } catch (e) {
      clearTextController();

      _loading = false;
    }
  }

  Future<void> fetchTasks() async {
    _loading = true;
    try {
      List<Task> allTasks = await _firestoreRepository.fetchTasks();
      taskList =
          allTasks.where((task) => isSameDay(task.date, selectedDate)).toList();
      taskList.sort((a, b) => a.time.compareTo(b.time));
      _loading = true;
    } catch (e) {
      _loading = true;
      rethrow;
    }
  }

  @action
  Future<void> deleteTask(BuildContext context, String taskId) async {
    try {
      await _firestoreRepository.deleteTask(taskId);
      await fetchTasks();
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> updateTask(BuildContext context, String taskId) async {
    _loading = true;
    try {
      if (formKey.currentState != null) {
        if (formKey.currentState!.validate()) {
          final data = {
            'id': taskId,
            'name': tarefaCtrl.text,
            'description': descrCtrl.text,
            'date':
                "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year.toString().padLeft(4, '0')}",
            'time': toBRDHr(timeOfDay),
            'priority': _selectedPriority,
            'isCompleted': false,
          };

          await _firestoreRepository.updateTask(taskId, data);

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
  Future<void> markTaskAsCompleted(
      BuildContext context, String taskId, bool isCompleted) async {
    try {
      await _firestoreRepository
          .updateTask(taskId, {'isCompleted': isCompleted});
    } catch (e) {
      rethrow;
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @action
  Future timePicker(BuildContext context) async {
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

  @action
  Future datePicker(BuildContext context) async {
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

  @action
  void setIsOpened(bool isOpen) {
    _isOpened = isOpen;
    print(_isOpened);
  }

  @action
  void setColor() {
    index = random.nextInt(4);
  }

  @action
  toggleComplete(BuildContext context, String taskId, bool isCompleted) async {
    isCompleted = !isCompleted;
    await markTaskAsCompleted(context, taskId, isCompleted);
  }

  @action
  void setSelectedPriority(String priority) {
    _selectedPriority = priority;
    // print(selectedPriority);
    switch (priority) {
      case 'high':
        priorityColor = Colors.red;
        break;
      case 'medium':
        priorityColor = Colors.orange;
        break;
      case 'low':
        priorityColor = Colors.green;
        break;
      default:
        priorityColor = Colors.grey;
    }
  }
}

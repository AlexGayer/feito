// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScheduleController on _ScheduleControllerBase, Store {
  Computed<bool>? _$isOpenedComputed;

  @override
  bool get isOpened =>
      (_$isOpenedComputed ??= Computed<bool>(() => super.isOpened,
              name: '_ScheduleControllerBase.isOpened'))
          .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_ScheduleControllerBase.loading'))
      .value;
  Computed<String>? _$selectedPriorityComputed;

  @override
  String get selectedPriority => (_$selectedPriorityComputed ??=
          Computed<String>(() => super.selectedPriority,
              name: '_ScheduleControllerBase.selectedPriority'))
      .value;

  late final _$_isOpenedAtom =
      Atom(name: '_ScheduleControllerBase._isOpened', context: context);

  @override
  bool get _isOpened {
    _$_isOpenedAtom.reportRead();
    return super._isOpened;
  }

  @override
  set _isOpened(bool value) {
    _$_isOpenedAtom.reportWrite(value, super._isOpened, () {
      super._isOpened = value;
    });
  }

  late final _$_loadingAtom =
      Atom(name: '_ScheduleControllerBase._loading', context: context);

  @override
  bool get _loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  late final _$colorAtom =
      Atom(name: '_ScheduleControllerBase.color', context: context);

  @override
  Color? get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(Color? value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  late final _$indexAtom =
      Atom(name: '_ScheduleControllerBase.index', context: context);

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  late final _$_selectedPriorityAtom =
      Atom(name: '_ScheduleControllerBase._selectedPriority', context: context);

  @override
  String get _selectedPriority {
    _$_selectedPriorityAtom.reportRead();
    return super._selectedPriority;
  }

  @override
  set _selectedPriority(String value) {
    _$_selectedPriorityAtom.reportWrite(value, super._selectedPriority, () {
      super._selectedPriority = value;
    });
  }

  late final _$priorityColorAtom =
      Atom(name: '_ScheduleControllerBase.priorityColor', context: context);

  @override
  Color get priorityColor {
    _$priorityColorAtom.reportRead();
    return super.priorityColor;
  }

  @override
  set priorityColor(Color value) {
    _$priorityColorAtom.reportWrite(value, super.priorityColor, () {
      super.priorityColor = value;
    });
  }

  late final _$taskListAtom =
      Atom(name: '_ScheduleControllerBase.taskList', context: context);

  @override
  List<Task> get taskList {
    _$taskListAtom.reportRead();
    return super.taskList;
  }

  @override
  set taskList(List<Task> value) {
    _$taskListAtom.reportWrite(value, super.taskList, () {
      super.taskList = value;
    });
  }

  late final _$colorsAtom =
      Atom(name: '_ScheduleControllerBase.colors', context: context);

  @override
  List<dynamic> get colors {
    _$colorsAtom.reportRead();
    return super.colors;
  }

  @override
  set colors(List<dynamic> value) {
    _$colorsAtom.reportWrite(value, super.colors, () {
      super.colors = value;
    });
  }

  late final _$userPhotoURLAtom =
      Atom(name: '_ScheduleControllerBase.userPhotoURL', context: context);

  @override
  String? get userPhotoURL {
    _$userPhotoURLAtom.reportRead();
    return super.userPhotoURL;
  }

  @override
  set userPhotoURL(String? value) {
    _$userPhotoURLAtom.reportWrite(value, super.userPhotoURL, () {
      super.userPhotoURL = value;
    });
  }

  late final _$initStateAsyncAction =
      AsyncAction('_ScheduleControllerBase.initState', context: context);

  @override
  Future initState() {
    return _$initStateAsyncAction.run(() => super.initState());
  }

  late final _$fetchUserPhotoURLAsyncAction = AsyncAction(
      '_ScheduleControllerBase.fetchUserPhotoURL',
      context: context);

  @override
  Future<void> fetchUserPhotoURL() {
    return _$fetchUserPhotoURLAsyncAction.run(() => super.fetchUserPhotoURL());
  }

  late final _$addTaskAsyncAction =
      AsyncAction('_ScheduleControllerBase.addTask', context: context);

  @override
  Future<void> addTask(BuildContext context) {
    return _$addTaskAsyncAction.run(() => super.addTask(context));
  }

  late final _$deleteTaskAsyncAction =
      AsyncAction('_ScheduleControllerBase.deleteTask', context: context);

  @override
  Future<void> deleteTask(BuildContext context, String taskId) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(context, taskId));
  }

  late final _$updateTaskAsyncAction =
      AsyncAction('_ScheduleControllerBase.updateTask', context: context);

  @override
  Future<void> updateTask(BuildContext context, String taskId) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(context, taskId));
  }

  late final _$markTaskAsCompletedAsyncAction = AsyncAction(
      '_ScheduleControllerBase.markTaskAsCompleted',
      context: context);

  @override
  Future<void> markTaskAsCompleted(
      BuildContext context, String taskId, bool isCompleted) {
    return _$markTaskAsCompletedAsyncAction
        .run(() => super.markTaskAsCompleted(context, taskId, isCompleted));
  }

  late final _$timePickerAsyncAction =
      AsyncAction('_ScheduleControllerBase.timePicker', context: context);

  @override
  Future<dynamic> timePicker(BuildContext context) {
    return _$timePickerAsyncAction.run(() => super.timePicker(context));
  }

  late final _$datePickerAsyncAction =
      AsyncAction('_ScheduleControllerBase.datePicker', context: context);

  @override
  Future<dynamic> datePicker(BuildContext context) {
    return _$datePickerAsyncAction.run(() => super.datePicker(context));
  }

  late final _$toggleCompleteAsyncAction =
      AsyncAction('_ScheduleControllerBase.toggleComplete', context: context);

  @override
  Future toggleComplete(BuildContext context, String taskId, bool isCompleted) {
    return _$toggleCompleteAsyncAction
        .run(() => super.toggleComplete(context, taskId, isCompleted));
  }

  late final _$_ScheduleControllerBaseActionController =
      ActionController(name: '_ScheduleControllerBase', context: context);

  @override
  dynamic clearTextController() {
    final _$actionInfo = _$_ScheduleControllerBaseActionController.startAction(
        name: '_ScheduleControllerBase.clearTextController');
    try {
      return super.clearTextController();
    } finally {
      _$_ScheduleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toBRDt(DateTime? date) {
    final _$actionInfo = _$_ScheduleControllerBaseActionController.startAction(
        name: '_ScheduleControllerBase.toBRDt');
    try {
      return super.toBRDt(date);
    } finally {
      _$_ScheduleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toBRDHr(TimeOfDay? time) {
    final _$actionInfo = _$_ScheduleControllerBaseActionController.startAction(
        name: '_ScheduleControllerBase.toBRDHr');
    try {
      return super.toBRDHr(time);
    } finally {
      _$_ScheduleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsOpened(bool isOpen) {
    final _$actionInfo = _$_ScheduleControllerBaseActionController.startAction(
        name: '_ScheduleControllerBase.setIsOpened');
    try {
      return super.setIsOpened(isOpen);
    } finally {
      _$_ScheduleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setColor() {
    final _$actionInfo = _$_ScheduleControllerBaseActionController.startAction(
        name: '_ScheduleControllerBase.setColor');
    try {
      return super.setColor();
    } finally {
      _$_ScheduleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedPriority(String priority) {
    final _$actionInfo = _$_ScheduleControllerBaseActionController.startAction(
        name: '_ScheduleControllerBase.setSelectedPriority');
    try {
      return super.setSelectedPriority(priority);
    } finally {
      _$_ScheduleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
color: ${color},
index: ${index},
priorityColor: ${priorityColor},
taskList: ${taskList},
colors: ${colors},
userPhotoURL: ${userPhotoURL},
isOpened: ${isOpened},
loading: ${loading},
selectedPriority: ${selectedPriority}
    ''';
  }
}

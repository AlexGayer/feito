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

  late final _$initStateAsyncAction =
      AsyncAction('_ScheduleControllerBase.initState', context: context);

  @override
  Future initState() {
    return _$initStateAsyncAction.run(() => super.initState());
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
  Future<void> deleteTask(String taskId) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(taskId));
  }

  late final _$_timePickerAsyncAction =
      AsyncAction('_ScheduleControllerBase._timePicker', context: context);

  @override
  Future<dynamic> _timePicker(BuildContext context) {
    return _$_timePickerAsyncAction.run(() => super._timePicker(context));
  }

  late final _$_datePickerAsyncAction =
      AsyncAction('_ScheduleControllerBase._datePicker', context: context);

  @override
  Future<dynamic> _datePicker(BuildContext context) {
    return _$_datePickerAsyncAction.run(() => super._datePicker(context));
  }

  late final _$_ScheduleControllerBaseActionController =
      ActionController(name: '_ScheduleControllerBase', context: context);

  @override
  dynamic getSchedule(BuildContext context) {
    final _$actionInfo = _$_ScheduleControllerBaseActionController.startAction(
        name: '_ScheduleControllerBase.getSchedule');
    try {
      return super.getSchedule(context);
    } finally {
      _$_ScheduleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

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
  String toString() {
    return '''
color: ${color},
index: ${index},
taskList: ${taskList},
colors: ${colors},
isOpened: ${isOpened},
loading: ${loading}
    ''';
  }
}

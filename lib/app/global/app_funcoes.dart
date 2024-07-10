// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:io';

import 'package:feito/app/domain/model/task.dart';
import 'package:feito/app/global/shared_preferences_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class AppFuncoes {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late tz.Location _local;

  Future<bool> isConfigured() async {
    final handler = SharedPreferencesHandler();
    final String edtMail = await handler.redPreferences("mail");
    final String edtPwd = await handler.redPreferences("password");

    if (edtMail.isNotEmpty && edtPwd.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> configureLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (payload == null || payload.isEmpty) {
          return;
        }
      },
    );

    if (Platform.isAndroid) {
      var androidPlugin =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlugin != null) {
        if (await androidPlugin.areNotificationsEnabled() != true) {
          await androidPlugin.requestNotificationsPermission();
        }
      }
    }

    if (Platform.isIOS) {
      bool permissionGranted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              ) ??
          false;
      if (!permissionGranted) {
        print('Permissão de notificação no iOS não concedida.');
        return;
      }
    }

    tz.initializeTimeZones();
    _local = tz.getLocation('America/Sao_Paulo');
    tz.setLocalLocation(_local);
    print('Fusos horários inicializados e fuso horário local definido.');
  }

  Future<void> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.scheduleExactAlarm.status;
      print('Status da permissão de alarme exato: $status');

      if (status.isDenied) {
        print('Permissão de alarme exato foi negada, solicitando permissão...');
        final newStatus = await Permission.scheduleExactAlarm.request();
        if (newStatus.isDenied) {
          print('Permissão para alarmes exatos negada.');
        } else if (newStatus.isPermanentlyDenied) {
          print('Permissão para alarmes exatos permanentemente negada.');
        } else if (newStatus.isGranted) {
          print('Permissão para alarmes exatos concedida.');
        }
      } else if (status.isGranted) {
        print('Permissão de alarme exato já concedida.');
      } else if (status.isPermanentlyDenied) {
        print('Permissão de alarme exato está permanentemente negada.');
      }
    }
  }

  Future<void> cancelTaskNotifications(String taskId) async {
    await flutterLocalNotificationsPlugin.cancel(taskId.hashCode);
    await flutterLocalNotificationsPlugin.cancel(taskId.hashCode + 1);
  }

  Future<bool> scheduleNotification(Task task) async {
    await configureLocalNotifications();
    await requestExactAlarmPermission();

    final TimeOfDay timeOfDay = task.getTimeOfDay();
    final scheduledDate = task.date
        .add(Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute));
    final fiveMinutesBefore =
        scheduledDate.subtract(const Duration(minutes: 5));

    const androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const iOSDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id.hashCode,
        'Task Reminder',
        'Task "${task.name}" is scheduled now!',
        tz.TZDateTime.from(scheduledDate, _local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      print('Notificação agendada para a hora exata da tarefa.');

      await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id.hashCode + 1,
        'Task Reminder',
        'Task "${task.name}" is scheduled in 5 minutes!',
        tz.TZDateTime.from(fiveMinutesBefore, _local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      print('Notificação agendada para 5 minutos antes da tarefa.');

      return true;
    } catch (e) {
      print('Erro ao agendar a notificação: $e');
      return false;
    }
  }
}

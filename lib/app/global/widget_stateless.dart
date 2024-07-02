import 'package:feito/di/di.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

abstract class WidgetStateless<Controller extends Store>
    extends StatelessWidget {
  final Controller controller = getIt<Controller>();

  WidgetStateless({super.key});
}

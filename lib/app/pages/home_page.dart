import 'package:feito/app/controller/schedule_controller.dart';
import 'package:feito/app/global/widget_stateful.dart';
import 'package:feito/app/widgets/card_task_widget.dart';
import 'package:feito/app/widgets/task_dialog_widget.dart';
import 'package:feito/app/widgets/week_day_slider_widget.dart';
import 'package:feito/app/widgets/fab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends WidgetStateful<HomePage, ScheduleController> {
  final customDialog = const TaskDialogWidget();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    controller.initState();
    super.initState();
  }

  final onDateSelected = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Container(
              color: Colors.black,
            ),
          ),
          SafeArea(
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text("Olá, Alexandre",
                    style: Theme.of(context).textTheme.titleLarge),
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        MdiIcons.bell,
                        color: Colors.white,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipOval(
                      child: Image.asset('images/foto.png'),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    child: WeekSlider(
                      initialDate: selectedDate,
                      onDateSelected: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Tarefas",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: Observer(
                        builder: (_) => ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: controller.taskList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => CardTaskWidget(
                            name: controller.taskList[index].name,
                            descripion: controller.taskList[index].description,
                            date: controller.taskList[index].date,
                            color: Colors.white,
                            onDelete: () => controller
                                .deleteTask(controller.taskList[index].id),
                            id: controller.taskList[index].id,
                          ),
                        ),
                      ))
                ],
              ),
              floatingActionButton: Observer(
                builder: (_) => FABWidget(
                  isOpened: controller.isOpened.obs(),
                  onPressed: () => controller.getSchedule(context),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
          ),
        ],
      ),
    );
  }
}

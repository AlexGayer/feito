import 'package:feito/app/controller/schedule_controller.dart';
import 'package:feito/app/global/widget_stateful.dart';
import 'package:feito/app/widgets/card_task_widget.dart';
import 'package:feito/app/widgets/custom_dialog_widget.dart';
import 'package:feito/app/widgets/gradient_background_widget.dart';
import 'package:feito/app/widgets/navigation_drawer_widget.dart';
import 'package:feito/app/widgets/week_day_slider_widget.dart';
import 'package:feito/app/widgets/fab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends WidgetStateful<HomePage, ScheduleController> {
  @override
  void initState() {
    super.initState();
    controller.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackgroundWidget(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              "Feito",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            backgroundColor: Colors.transparent,
            actions: [
              Observer(
                builder: (_) {
                  if (controller.userPhotoURL != null) {
                    return CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(controller.userPhotoURL!),
                      backgroundColor: Colors.transparent,
                    );
                  } else if (controller.loading) {
                    return const CircularProgressIndicator();
                  } else {
                    return const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white, size: 40),
                    );
                  }
                },
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  MdiIcons.bell,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  child: WeekSlider(
                    initialDate: controller.selectedDate,
                    onDateSelected: (date) {
                      setState(() {
                        controller.selectedDate = date;
                        controller.fetchTasks();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Observer(
                  builder: (_) => controller.taskList.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: controller.taskList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var task = controller.taskList[index];
                                  return CardTaskWidget(
                                    task: task,
                                    name: task.name,
                                    descripion: task.description,
                                    date: controller.toBRDt(task.date),
                                    time: task.time,
                                    color: task.getPriorityColor(),
                                    completedColor: task.getCompletedColor(),
                                    onDelete: () =>
                                        controller.deleteTask(context, task.id),
                                    onComplete: () => controller.toggleComplete(
                                        context, task.id, task.isCompleted),
                                    onEdit: () {},
                                    id: task.id,
                                    completed: task.isCompleted,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          drawer: const NavigationDrawerWidget(),
          floatingActionButton: Observer(
            builder: (_) => FABWidget(
              isOpened: controller.isOpened,
              onPressed: () {
                controller.setIsOpened(true);
                showGeneralDialog(
                  context: context,
                  barrierLabel: "",
                  barrierDismissible: false,
                  barrierColor: Colors.black.withOpacity(0.6),
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, anim1, anim2) {
                    return const SizedBox.expand(
                      child: CustomDialogWidget(),
                    );
                  },
                  transitionBuilder: (context, anim1, anim2, child) {
                    return SlideTransition(
                      position: Tween(
                        begin: const Offset(0, 1),
                        end: const Offset(0, 0),
                      ).animate(anim1),
                      child: child,
                    );
                  },
                ).then((_) => setState(() {
                      controller.setIsOpened(false);
                      controller.fetchTasks();
                    }));
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}

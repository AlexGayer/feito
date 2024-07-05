// ignore_for_file: library_private_types_in_public_api

import 'package:feito/app/controller/schedule_controller.dart';
import 'package:feito/app/global/widget_stateful.dart';
import 'package:feito/app/widgets/elevated_button_priority_widget.dart';
import 'package:feito/app/widgets/elevated_button_widget.dart';
import 'package:feito/app/widgets/text_button_container.dart';
import 'package:feito/app/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomDialogWidget extends StatefulWidget {
  const CustomDialogWidget({super.key});

  @override
  _CustomDialogWidgetState createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState
    extends WidgetStateful<CustomDialogWidget, ScheduleController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.height * 0.5,
        margin: const EdgeInsets.only(bottom: 50, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Material(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 20),
                        child: Text("Criar nova tarefa",
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            MdiIcons.close,
                            size: 30,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: TextFieldContainer(
                      controller: controller.tarefaCtrl,
                      hintText: "Nome da Tarefa",
                      validatorText: "Informe o nome da tarefa !",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: TextFieldContainer(
                      controller: controller.descrCtrl,
                      hintText: "Descrição",
                      validatorText: "Informe a descrição da tarefa !",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButtonContainer(
                          hintText: "Data",
                          timeCtrl: controller.dateCtrl,
                          onPressed: () => controller.datePicker(context),
                          validatorText: "Informe uma data !",
                          icon: MdiIcons.calendar,
                        ),
                        TextButtonContainer(
                          hintText: "Horário",
                          validatorText: "Informe um horário !",
                          timeCtrl: controller.timeCtrl,
                          onPressed: () => controller.timePicker(context),
                          icon: MdiIcons.clock,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 10),
                          child: Text("Selecione a prioridade",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        Observer(
                          builder: (_) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButtonPriorityWidget(
                                width: size.width * 0.25,
                                label: "Alta",
                                borderRadius: BorderRadius.circular(20),
                                onPressed: () =>
                                    controller.setSelectedPriority("high"),
                                color: controller.selectedPriority == "high"
                                    ? controller.priorityColor
                                    : null,
                              ),
                              ElevatedButtonPriorityWidget(
                                width: size.width * 0.25,
                                label: "Média",
                                borderRadius: BorderRadius.circular(20),
                                onPressed: () =>
                                    controller.setSelectedPriority("medium"),
                                color: controller.selectedPriority == "medium"
                                    ? controller.priorityColor
                                    : null,
                              ),
                              ElevatedButtonPriorityWidget(
                                width: size.width * 0.25,
                                label: "Baixa",
                                borderRadius: BorderRadius.circular(20),
                                onPressed: () =>
                                    controller.setSelectedPriority("low"),
                                color: controller.selectedPriority == "low"
                                    ? controller.priorityColor
                                    : null,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButtonWidget(
                        borderRadius: BorderRadius.circular(20),
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.addTask(context);

                            Navigator.of(context).pop();
                          }
                        },
                        label: "Registrar Tarefa",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

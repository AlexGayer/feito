import 'package:feito/app/widgets/elevated_button_priority_widget.dart';
import 'package:feito/app/widgets/elevated_button_widget.dart';
import 'package:feito/app/widgets/text_button_container.dart';
import 'package:feito/app/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// Substitua pelo seu import real

class CustomDialogWidget extends StatefulWidget {
  final TextEditingController tarefaCtrl;
  final TextEditingController descrCtrl;
  final TextEditingController timeCtrl;
  final TextEditingController dateCtrl;
  final GlobalKey<FormState> formKey;
  final Function() datePicker;
  final Function() timePicker;
  final Function() addList;
  final Function() close;

  CustomDialogWidget({
    required this.tarefaCtrl,
    required this.descrCtrl,
    required this.timeCtrl,
    required this.dateCtrl,
    required this.formKey,
    required this.datePicker,
    required this.timePicker,
    required this.addList,
    required this.close,
  });

  @override
  _CustomDialogWidgetState createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.height * 0.45,
        margin: const EdgeInsets.only(bottom: 50, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Form(
            key: widget.formKey,
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
                          onPressed: widget.close,
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
                      controller: widget.tarefaCtrl,
                      hintText: "Nome da Tarefa",
                      validatorText: "Informe o nome da tarefa !",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: TextFieldContainer(
                      controller: widget.descrCtrl,
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
                          timeCtrl: widget.dateCtrl,
                          onPressed: widget.datePicker,
                          validatorText: "Informe uma data !",
                          icon: MdiIcons.calendar,
                        ),
                        TextButtonContainer(
                          hintText: "Horário",
                          validatorText: "Informe um horário !",
                          timeCtrl: widget.timeCtrl,
                          onPressed: widget.timePicker,
                          icon: MdiIcons.clock,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButtonPriorityWidget(
                          label: "Alta",
                          borderRadius: BorderRadius.circular(20),
                        ),
                        ElevatedButtonPriorityWidget(
                          label: "Média",
                          borderRadius: BorderRadius.circular(20),
                        ),
                        ElevatedButtonPriorityWidget(
                          label: "Baixa",
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                          if (widget.formKey.currentState!.validate()) {
                            widget.addList();
                            widget.close();
                          }
                        },
                        child: Text(
                          "Registrar Tarefa",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
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

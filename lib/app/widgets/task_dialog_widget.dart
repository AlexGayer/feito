import 'package:feito/app/widgets/text_button_container.dart';
import 'package:feito/app/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TaskDialogWidget extends StatelessWidget {
  const TaskDialogWidget({super.key});

  showTaskDialog(
    BuildContext context,
    TextEditingController tarefaCtrl,
    TextEditingController descrCtrl,
    TextEditingController timeCtrl,
    TextEditingController dateCtrl,
    GlobalKey<FormState> formKey,
    Function() datePicker,
    Function() timePicker,
    Function() addList,
    Function() close,
  ) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "Label",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) => _renderingCustomDialog(
          context,
          tarefaCtrl,
          descrCtrl,
          timeCtrl,
          dateCtrl,
          formKey,
          datePicker,
          timePicker,
          addList,
          close),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  Widget _renderingCustomDialog(
    BuildContext context,
    TextEditingController tarefaCtrl,
    TextEditingController descrCtrl,
    TextEditingController timeCtrl,
    TextEditingController dateCtrl,
    GlobalKey<FormState> formKey,
    Function() datePicker,
    Function() timePicker,
    Function() addList,
    Function() close,
  ) {
    final size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.height * 0.4,
        margin: const EdgeInsets.only(bottom: 50, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                        child: Text("Adicionar Tarefa",
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      IconButton(
                          onPressed: close,
                          icon: Icon(
                            MdiIcons.close,
                            size: 20,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  TextFieldContainer(
                    controller: tarefaCtrl,
                    hintText: "Nome da Tarefa",
                    validatorText: "Informe o nome da tarefa !",
                  ),
                  TextFieldContainer(
                    controller: descrCtrl,
                    hintText: "Descrição",
                    validatorText: "Informe a descrição da tarefa !",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButtonContainer(
                        hintText: "Data",
                        timeCtrl: dateCtrl,
                        onPressed: datePicker,
                        validatorText: "Informe uma data !",
                        icon: MdiIcons.calendar,
                      ),
                      const SizedBox(height: 10),
                      TextButtonContainer(
                        hintText: "Horário",
                        validatorText: "Informe um horário !",
                        timeCtrl: timeCtrl,
                        onPressed: timePicker,
                        icon: MdiIcons.clock,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              addList();
                              close();
                            }
                          },
                          child: Text(
                            "Registrar Tarefa",
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

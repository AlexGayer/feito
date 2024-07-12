import 'dart:io';

import 'package:feito/app/controller/login_controller.dart';
import 'package:feito/app/global/widget_stateful.dart';
import 'package:feito/app/widgets/custom_app_bar_widget.dart';
import 'package:feito/app/widgets/elevated_button_widget.dart';
import 'package:feito/app/widgets/gradient_background_widget.dart';
import 'package:feito/app/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends WidgetStateful<CadastroPage, LoginController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: GradientBackgroundWidget(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Faça o cadastro de sua conta",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Observer(
                  builder: (_) => Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.black,
                              child: controller.pickedImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(
                                          File(controller.pickedImage!.path)),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child:
                                          Image.asset("assets/images/user.png"),
                                    )),
                          Positioned(
                            left: 120,
                            bottom: 10,
                            child: IconButton(
                              onPressed: () async {
                                await controller.getImageGallery();
                              },
                              icon: Icon(
                                MdiIcons.cameraPlus,
                                color: Colors.cyan,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldContainer(
                          focus: controller.focusName,
                          controller: controller.nameCtrl,
                          hintText: "Nome completo",
                          validatorText: "Informe seu nome !",
                          icon: MdiIcons.account,
                        ),
                        const SizedBox(height: 10),
                        TextFieldContainer(
                          email: true,
                          focus: controller.focusEmail,
                          controller: controller.emailCtrl,
                          hintText: "Email",
                          validatorText: "Informe seu email !",
                          icon: MdiIcons.email,
                        ),
                        const SizedBox(height: 10),
                        TextFieldContainer(
                          pwd: true,
                          focus: controller.focusPwd,
                          controller: controller.pwdCtrl,
                          hintText: "Senha",
                          validatorText: "Informe sua senha !",
                          icon: MdiIcons.lock,
                        ),
                        const SizedBox(height: 20),
                        Observer(
                          builder: (_) => SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: controller.loading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButtonWidget(
                                    onPressed: () async {
                                      controller.setFirstLogin(true);
                                      controller.login(context);
                                    },
                                    label: "Realizar Cadastro",
                                  ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

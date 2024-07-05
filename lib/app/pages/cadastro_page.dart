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
    final size = MediaQuery.of(context).size;
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset("images/todo.png"),
                ),
                Text(
                  "Realize o seu cadastro",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                SizedBox(height: size.height * 0.05),
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
                        const SizedBox(height: 10),
                        TextFieldContainer(
                          newPwd: true,
                          pwd: true,
                          focus: controller.focusNewPwd,
                          controller: controller.newPwdCtrl,
                          hintText: "Confirmar senha",
                          validatorText: "Confirme sua senha !",
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
                                      controller.login(context);
                                      controller.setFirstLogin(true);
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

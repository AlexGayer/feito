import 'package:feito/app/controller/login_controller.dart';
import 'package:feito/app/global/widget_stateful.dart';
import 'package:feito/app/widgets/custom_app_bar_widget.dart';
import 'package:feito/app/widgets/elevated_button_widget.dart';
import 'package:feito/app/widgets/gradient_background_widget.dart';
import 'package:feito/app/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({
    super.key,
  });

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState
    extends WidgetStateful<PasswordWidget, LoginController> {
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
                  "Faça login em sua conta",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  "Por favor, preencha suas informações abaixo para acessar uma conta na Feito ",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.05),
                Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldContainer(
                          pwd: false,
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
                        TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacementNamed("/cadastro"),
                            child: Text("Esqueceu sua senha ?",
                                style: Theme.of(context).textTheme.bodySmall)),
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
                                    },
                                    label: "Alterar Senha",
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

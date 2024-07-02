import 'package:feito/app/controller/login_controller.dart';
import 'package:feito/app/global/widget_stateful.dart';
import 'package:feito/app/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends WidgetStateful<LoginPage, LoginController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                height: size.height,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 400,
                          child: Image.asset("images/todo.png"),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                TextFieldContainer(
                                  pwd: false,
                                  focus: controller.focusEmail,
                                  controller: controller.emailCtrl,
                                  hintText: "Email",
                                  validatorText: "Informe seu email !",
                                  icon: MdiIcons.email,
                                ),
                                TextFieldContainer(
                                  pwd: true,
                                  focus: controller.focusPwd,
                                  controller: controller.pwdCtrl,
                                  hintText: "Senha",
                                  validatorText: "Informe sua senha !",
                                  icon: MdiIcons.lock,
                                ),
                                controller.firstAccess
                                    ? TextFieldContainer(
                                        pwd: true,
                                        controller: controller.newPwdCtrl,
                                        hintText: "Confirme a senha",
                                        validatorText: "Confime sua senha !",
                                        icon: MdiIcons.lock,
                                      )
                                    : Container(),
                                const SizedBox(height: 10),
                                Observer(
                                  builder: (_) => SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: controller.loading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            )),
                                            onPressed: () async =>
                                                controller.login(context),
                                            child: !controller.firstAccess
                                                ? Text(
                                                    "Acessar",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                                  )
                                                : Text(
                                                    "Cadastrar",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                                  )),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Não é cadastrado?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            controller.changeFirstAcces();
                                          });
                                        },
                                        child: Text(
                                          "Cadastre-se",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ))
                                  ],
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

import 'package:feito/app/controller/login_controller.dart';
import 'package:feito/app/global/widget_stateful.dart';
import 'package:feito/app/widgets/elevated_button_widget.dart';
import 'package:feito/app/widgets/gradient_background_widget.dart';
import 'package:flutter/material.dart';

class InicialPage extends StatefulWidget {
  const InicialPage({super.key});

  @override
  State<InicialPage> createState() => _InicialPageState();
}

class _InicialPageState extends WidgetStateful<InicialPage, LoginController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: const CustomAppBar(),
      body: GradientBackgroundWidget(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: size.height,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    child: Image.asset("assets/images/todo.png"),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bem-vindo !",
                            style: Theme.of(context).textTheme.headlineLarge),
                        controller.loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButtonWidget(
                                height: 50,
                                width: size.width,
                                onPressed: () =>
                                    Navigator.of(context).pushNamed("/login"),
                                label: "Iniciar",
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:feito/app/widgets/list_tile_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          builMenudItems(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, bottom: 20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("images/foto.png"),
            ),
            const SizedBox(height: 12),
            Text(
              "Nome Usuário",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Email Usuário",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      );
  Widget builMenudItems(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Wrap(
          runSpacing: 20,
          runAlignment: WrapAlignment.center,
          children: [
            ListTileDrawerWidget(
                title: "Home",
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed("/home"),
                icon: MdiIcons.home),
            ListTileDrawerWidget(
                title: "Notificações",
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed("/home"),
                icon: MdiIcons.bell),
            ListTileDrawerWidget(
                title: "Tarefas Realizadas",
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed("/home"),
                icon: MdiIcons.calendarCheck),
            ListTileDrawerWidget(
                title: "Sair",
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed("/login"),
                icon: MdiIcons.exitToApp),
          ],
        ),
      );
}

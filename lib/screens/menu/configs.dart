import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../utils/app_routes.dart';
import '../../utils/statusFree_User.dart';
import '../../utils/tema.dart';

class ConfigsScreen extends StatefulWidget {
  const ConfigsScreen({super.key});

  @override
  State<ConfigsScreen> createState() => _ConfigsScreenState();
}

class _ConfigsScreenState extends State<ConfigsScreen> {
  late int theme;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  Widget build(BuildContext context) {
    readTheme();

    int status = context.watch<StatusFreeUser>().getStatus;
    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;
    Color secundaryColor = status == 0
        ? context.watch<TemaApp>().getSecundaryColorUser
        : context.watch<TemaApp>().getSecundaryColorFree;
    Color backColor = status == 0
        ? context.watch<TemaApp>().getBackgroundColorUser
        : context.watch<TemaApp>().getBackgroundColorFree;
    Color textColor = status == 0
        ? context.watch<TemaApp>().getTextColorUser
        : context.watch<TemaApp>().getTextColorFree;

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme == 0 ? primaryColor : backColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: theme == 0
            ? const Color.fromARGB(255, 250, 253, 255)
            : secundaryColor,
        title: Text(
          'Configurações',
          style: TextStyle(color: theme == 0 ? primaryColor : backColor),
        ),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.notifications,
                size: 25,
                color: textColor,
              ),
              title: Text(
                'Notificações',
                style: TextStyle(fontSize: 16, color: textColor),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.archive,
                size: 25,
                color: textColor,
              ),
              title: Text(
                'Projetos',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.work,
                size: 25,
                color: textColor,
              ),
              title: Text(
                'Anúncios',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.lock,
                size: 25,
                color: textColor,
              ),
              title: Text(
                'Privacidade',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.privacy_tip,
                size: 25,
                color: textColor,
              ),
              title: Text(
                'Segurança',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.account_circle,
                size: 25,
                color: textColor,
              ),
              title: Text(
                'Conta',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.help,
                size: 25,
                color: textColor,
              ),
              title: Text(
                'Ajuda',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.info,
                size: 25,
                color: textColor,
              ),
              title: Text(
                'Sobre',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.color_lens,
                size: 25,
                color: textColor,
              ),
              title: Text(
                'Tema',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.tema);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.opening);
              },
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 1,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: textColor,
                    ),
                  ),
                ),
                child: Text(
                  'Sair',
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../utils/app_routes.dart';
import '../../utils/statusFree_User.dart';
import '../../utils/tema.dart';

class ConfigsScreen extends StatelessWidget {
  const ConfigsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int status = context.watch<StatusFreeUser>().getStatus;
    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color.fromARGB(255, 250, 253, 255),
        title: Text(
          'Configurações',
          style: TextStyle(color: primaryColor),
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
              leading: const Icon(
                Icons.notifications,
                size: 25,
              ),
              title: const Text(
                'Notificações',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.archive,
                size: 25,
              ),
              title: const Text(
                'Projetos',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.work,
                size: 25,
              ),
              title: const Text(
                'Anúncios',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.lock,
                size: 25,
              ),
              title: const Text(
                'Privacidade',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.privacy_tip,
                size: 25,
              ),
              title: const Text(
                'Segurança',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.account_circle,
                size: 25,
              ),
              title: const Text(
                'Conta',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.help,
                size: 25,
              ),
              title: const Text(
                'Ajuda',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.info,
                size: 25,
              ),
              title: const Text(
                'Sobre',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.color_lens,
                size: 25,
              ),
              title: const Text(
                'Tema',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.tema);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Login',
              style: TextStyle(fontSize: 18),
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
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                    ),
                  ),
                ),
                child: const Text(
                  'Sair',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

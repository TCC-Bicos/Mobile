import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../providers/clientProvider.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/statusFree_User.dart';
import '../../../utils/tema.dart';

class ContaConfigs extends StatefulWidget {
  const ContaConfigs({Key? key}) : super(key: key);

  @override
  State<ContaConfigs> createState() => _ContaConfigsState();
}

class _ContaConfigsState extends State<ContaConfigs> {
  late int theme;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  ClienteProvider _clienteProvider = ClienteProvider();

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
          'Conta',
          style: TextStyle(color: theme == 0 ? primaryColor : backColor),
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
            title: Text(
              'Informações pessoais',
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.infoPessoais);
            },
          ),
        ],
      ),
    );
  }
}

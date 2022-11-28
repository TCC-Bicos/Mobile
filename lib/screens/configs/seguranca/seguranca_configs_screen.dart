import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../providers/clientProvider.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/statusFree_User.dart';
import '../../../utils/tema.dart';

class SegurancaConfigs extends StatefulWidget {
  const SegurancaConfigs({Key? key}) : super(key: key);

  @override
  State<SegurancaConfigs> createState() => _SegurancaConfigsState();
}

class _SegurancaConfigsState extends State<SegurancaConfigs> {
  late int theme;
  late int status;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  void initState() {
    super.initState();
    status = StatusFreeUser.getStatus();
  }

  @override
  Widget build(BuildContext context) {
    readTheme();

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
          'Segurança',
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
            leading: Icon(
              Icons.vpn_key,
              size: 25,
              color: textColor,
            ),
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
            title: Text(
              'Senha',
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.senhaConfigs);
            },
          ),
        ],
      ),
    );
  }
}

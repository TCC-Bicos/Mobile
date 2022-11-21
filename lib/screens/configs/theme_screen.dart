import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../utils/statusFree_User.dart';
import '../../utils/tema.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
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

    final temaValue = theme == 0 ? 1 : 0;

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
      backgroundColor: status == 0
          ? context.watch<TemaApp>().getBackgroundColorUser
          : context.watch<TemaApp>().getBackgroundColorFree,
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
          'Tema',
          style: TextStyle(color: theme == 0 ? primaryColor : backColor),
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Radio(
                fillColor:
                    MaterialStateColor.resolveWith((states) => primaryColor),
                value: 0,
                groupValue: theme,
                onChanged: ((value) {
                  setState(() {
                    context.read<TemaApp>().setTheme(temaValue);
                  });
                }),
              ),
              SizedBox(
                width: MediaQuery.of(this.context).size.height * 0.01,
              ),
              Text(
                'Claro',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                fillColor:
                    MaterialStateColor.resolveWith((states) => primaryColor),
                value: 1,
                groupValue: theme,
                onChanged: ((value) {
                  setState(() {
                    context.read<TemaApp>().setTheme(temaValue);
                  });
                }),
              ),
              SizedBox(
                width: MediaQuery.of(this.context).size.height * 0.01,
              ),
              Text(
                'Escuro',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

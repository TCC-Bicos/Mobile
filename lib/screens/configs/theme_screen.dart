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

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  Widget build(BuildContext context) {
    readTheme();

    final temaValue = theme == 0 ? 1 : 0;

    int status = context.watch<StatusFreeUser>().getStatus;
    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;

    return Scaffold(
      backgroundColor: status == 0
          ? context.watch<TemaApp>().getBackgroundColorUser
          : context.watch<TemaApp>().getBackgroundColorFree,
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
          'Tema',
          style: TextStyle(color: primaryColor),
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Radio(
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
              const Text(
                'Claro',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 104, 111, 118),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
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
              const Text(
                'Escuro',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 104, 111, 118),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

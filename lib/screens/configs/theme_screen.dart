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
  @override
  Widget build(BuildContext context) {
    Object? _temaValue = context.watch<TemaApp>().getTemaClaroEscuro;

    Color backcolor = context.watch<TemaApp>().getBackgroundColor;

    int status = context.watch<StatusFreeUser>().getStatus;
    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;

    return Scaffold(
      backgroundColor: backcolor,
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
                groupValue: _temaValue,
                onChanged: ((value) {
                  setState(() {
                    context.read<TemaApp>().temaClaro();
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
                groupValue: _temaValue,
                onChanged: ((value) {
                  setState(() {
                    context.read<TemaApp>().temaEscuro();
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

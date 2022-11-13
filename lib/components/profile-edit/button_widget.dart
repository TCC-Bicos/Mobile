import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../utils/statusFree_User.dart';
import '../../utils/tema.dart';

class ButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
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
    Color backColor = status == 0
        ? context.watch<TemaApp>().getBackgroundColorUser
        : context.watch<TemaApp>().getBackgroundColorFree;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: theme == 0 ? Colors.white : backColor,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
      onPressed: widget.onClicked,
      child: Text(widget.text),
    );
  }
}

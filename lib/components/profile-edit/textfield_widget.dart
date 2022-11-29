import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../utils/statusFree_User.dart';
import '../../utils/tema.dart';

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  late int theme;
  late int status;

  @override
  void initState() {
    super.initState();
    status = StatusFreeUser.getStatus();
    controller = TextEditingController(text: widget.text);
  }

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    readTheme();

    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;
    Color textColor = status == 0
        ? context.watch<TemaApp>().getTextColorUser
        : context.watch<TemaApp>().getTextColorFree;
    Color backColor = status == 0
        ? context.watch<TemaApp>().getBackgroundColorUser
        : context.watch<TemaApp>().getBackgroundColorFree;
    Color darkBackColor = context.watch<TemaApp>().getDarkBackgroundColor;
    Color secTextColor = context.watch<TemaApp>().getSecundaryTextColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          style: TextStyle(color: textColor),
          controller: controller,
          maxLines: widget.maxLines != 5 ? widget.maxLines : null,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            counterStyle: TextStyle(color: textColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: textColor),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: primaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 10,
              right: 10,
            ),
          ),
          maxLength: widget.maxLines == 5 ? 300 : null,
        ),
      ],
    );
  }
}

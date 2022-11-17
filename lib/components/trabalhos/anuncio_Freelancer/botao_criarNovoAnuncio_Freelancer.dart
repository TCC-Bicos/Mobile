import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../utils/tema.dart';

class CriarNovoAnuncioFreelancerBotao extends StatefulWidget {
  const CriarNovoAnuncioFreelancerBotao({Key? key}) : super(key: key);

  @override
  State<CriarNovoAnuncioFreelancerBotao> createState() =>
      _CriarNovoAnuncioFreelancerBotaoState();
}

class _CriarNovoAnuncioFreelancerBotaoState
    extends State<CriarNovoAnuncioFreelancerBotao> {
  late int theme;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  Widget build(BuildContext context) {
    readTheme();

    Color primaryColor = context.watch<TemaApp>().getPrimaryColorFree;
    Color secundaryColor = context.watch<TemaApp>().getSecundaryColorFree;
    Color textColor = context.watch<TemaApp>().getTextColorFree;
    Color secTextColor = context.watch<TemaApp>().getSecundaryTextColor;
    Color backColor = context.watch<TemaApp>().getBackgroundColorFree;

    return Column(
      children: [
        SizedBox(
          width: 220,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                  theme == 0 ? Colors.white : backColor),
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: primaryColor),
                ),
              ),
            ),
            child: const Text(
              'Criar anúncio',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../utils/app_routes.dart';

class NovaSolicitacaoBotao extends StatelessWidget {
  const NovaSolicitacaoBotao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 33,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.novaSolicitacao);
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 24, 145, 250)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 24, 145, 250)),
                ),
              ),
            ),
            child: const Text(
              'Solicitar',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

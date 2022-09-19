import 'package:bicos_app/components/trabalhos/servicos/servicos_carousel.dart';
import 'package:bicos_app/components/trabalhos/projetos/projetos_carousel.dart';
import 'package:bicos_app/components/trabalhos/solicitacoes/solicitacoes_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TrabalhosScreen extends StatelessWidget {
  const TrabalhosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 35),
            child: const Text(
              'Trabalhos',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 0, 38, 92),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          const ServicosCarousel(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          const SolicitacaoCarousel(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          const ProjetosCarousel(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ],
      ),
    );
  }
}

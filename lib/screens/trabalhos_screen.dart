import 'package:bicos_app/components/trabalhos/anuncio_Freelancer/anuncios_Freelancer_carousel.dart';
import 'package:bicos_app/components/trabalhos/projetos/projetos_carousel.dart';
import 'package:bicos_app/components/trabalhos/anuncio_Usuario/anuncios_Usuario_carousel.dart';
import 'package:bicos_app/utils/statusFree_User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class TrabalhosScreen extends StatelessWidget {
  const TrabalhosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int status = Provider.of<StatusFreeUser>(context).getStatus();
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
          status == 0
              ? const AnuncioUsuarioCarousel()
              : const AnunciosFreelancerCarousel(),
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

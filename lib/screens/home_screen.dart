import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../components/home/constants.dart';
import '../components/home/prj_populares.dart';
import '../components/home/prj_recomendados.dart';
import '../components/home/title_with_more_bbtn.dart';
import '../utils/statusFree_User.dart';
import '../utils/tema.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int status = context.watch<StatusFreeUser>().getStatus;
    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: status == 0
          ? context.watch<TemaApp>().getBackgroundColorUser
          : context.watch<TemaApp>().getBackgroundColorFree,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleWithMoreBtn(title: "Recomendado", press: () {}),
              PrjRecomendados(),
              TitleWithMoreBtn(title: "Projetos Populares", press: () {}),
              PrjPopulares(),
              SizedBox(height: kDefaultPadding),
            ],
          ),
        ],
      ),
    );
  }
}

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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late int status;

  @override
  void initState() {
    super.initState();
    status = StatusFreeUser.getStatus();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;
    Size size = MediaQuery.of(context).size;

    super.build(context);

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
              PrjRecomendados(
                index: status == 0 ? 1 : 2,
              ),
              TitleWithMoreBtn(title: "Projetos Populares", press: () {}),
              const PrjPopulares(),
              const SizedBox(height: kDefaultPadding),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

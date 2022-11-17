import 'package:bicos_app/utils/statusFree_User.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app_routes.dart';
import '../utils/tema.dart';

class TrabalhosScreen extends StatefulWidget {
  const TrabalhosScreen({Key? key}) : super(key: key);

  @override
  State<TrabalhosScreen> createState() => _TrabalhosScreenState();
}

class _TrabalhosScreenState extends State<TrabalhosScreen>
    with AutomaticKeepAliveClientMixin {
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
    Color textColor = status == 0
        ? context.watch<TemaApp>().getTextColorUser
        : context.watch<TemaApp>().getTextColorFree;
    Color backColor = status == 0
        ? context.watch<TemaApp>().getBackgroundColorUser
        : context.watch<TemaApp>().getBackgroundColorFree;

    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();

    super.build(context);

    return Scaffold(
      backgroundColor: backColor,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 35),
            child: Text(
              'Trabalhos',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Meus anúncios',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 33,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(status == 0
                            ? AppRoutes.novoAnuncioUsuario
                            : AppRoutes.novoAnuncioFreelancer);
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            theme == 0 ? Colors.white : backColor),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: primaryColor),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Novo anúncio',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    autoPlay: false,
                  ),
                  items: imageSliders,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 35,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.2,
                    right: MediaQuery.of(context).size.width * 0.2,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          theme == 0 ? Colors.white : backColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Ver todos',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Projetos',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    autoPlay: false,
                  ),
                  items: imageSliders,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 35,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.2,
                    right: MediaQuery.of(context).size.width * 0.2,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          theme == 0 ? Colors.white : backColor),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Ver todos',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

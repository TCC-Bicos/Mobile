import 'dart:io';

import 'package:bicos_app/model/anuncio_Freelancer.dart';
import 'package:bicos_app/model/anuncio_Usuario.dart';
import 'package:bicos_app/model/freelancer.dart';
import 'package:bicos_app/providers/anunFreelancerProvider.dart';
import 'package:bicos_app/providers/anunUserProvider.dart';
import 'package:bicos_app/utils/freelancer_preferences.dart';
import 'package:bicos_app/utils/statusFree_User.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cliente.dart';
import '../utils/app_routes.dart';
import '../utils/tema.dart';
import '../utils/user_preferences.dart';

class TodosMeusAnunciosScreen extends StatefulWidget {
  const TodosMeusAnunciosScreen({Key? key}) : super(key: key);

  @override
  State<TodosMeusAnunciosScreen> createState() =>
      _TodosMeusAnunciosScreenState();
}

class _TodosMeusAnunciosScreenState extends State<TodosMeusAnunciosScreen> {
  late int theme;
  late int status;
  late User user;
  late Freelancer freelancer;
  late List<AnuncioUsuario> _anunciosUser;
  late List<AnuncioFreelancer> _anunciosFreelancer;

  bool _isLoading = true;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  void initState() {
    super.initState();
    status = StatusFreeUser.getStatus();
    user = UserPreferences.getUser();
    freelancer = FreelancerPreferences.getFreelancer();
    Future.delayed(Duration.zero, () {
      status == 0
          ? Provider.of<AnunUserProvider>(context, listen: false)
              .loadAnunMyUser(user.idUser)
              .then((value) {
              setState(() {
                _isLoading = false;
              });
            })
          : Provider.of<AnunFreelancerProvider>(context, listen: false)
              .loadAnunMyFreelancer(freelancer.idFr)
              .then((value) {
              setState(() {
                _isLoading = false;
              });
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    readTheme();
    status == 0
        ? _anunciosUser =
            Provider.of<AnunUserProvider>(context).getAnunciosMyUser()
        : _anunciosFreelancer = Provider.of<AnunFreelancerProvider>(context)
            .getAnunciosMyFreelancer();

    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;
    Color secundaryColor = status == 0
        ? context.watch<TemaApp>().getSecundaryColorUser
        : context.watch<TemaApp>().getSecundaryColorFree;
    Color textColor = status == 0
        ? context.watch<TemaApp>().getTextColorUser
        : context.watch<TemaApp>().getTextColorFree;
    Color backColor = status == 0
        ? context.watch<TemaApp>().getBackgroundColorUser
        : context.watch<TemaApp>().getBackgroundColorFree;
    Color darkBackColor = context.watch<TemaApp>().getDarkBackgroundColor;
    Color secTextColor = context.watch<TemaApp>().getSecundaryTextColor;

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme == 0 ? primaryColor : Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: theme == 0 ? Colors.white : secundaryColor,
        title: Image.asset(
          status == 0
              ? theme == 0
                  ? 'assets/images/bicoslogo_azul.png'
                  : 'assets/images/bicoslogo.png'
              : theme == 0
                  ? 'assets/images/bicoslogo_verde.png'
                  : 'assets/images/bicoslogo.png',
          fit: BoxFit.contain,
          height: 22,
        ),
        elevation: 1,
      ),
      body: _isLoading
          ? Center(
              child: Column(
              children: const [
                SizedBox(
                  height: 30,
                ),
                CircularProgressIndicator(),
              ],
            ))
          : ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 35),
                  child: Text(
                    'Meus anúncios',
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
                    Center(
                      child: status == 0
                          ? _anunciosUser.isEmpty
                              ? SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                          0.747175 -
                                      60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.work_off,
                                        color: secTextColor,
                                        size: 70,
                                      ),
                                      Text(
                                        'Nenhum anúncio encontrado',
                                        style: TextStyle(
                                            fontSize: 16, color: secTextColor),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    Column(
                                      children: _anunciosUser
                                          .map((e) => Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.30,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.90,
                                                    child: e.ImgAnunUser ==
                                                            'assets/images/testeImagemAnun.png'
                                                        ? Image.asset(
                                                            e.ImgAnunUser,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.file(
                                                            File(e.ImgAnunUser),
                                                            fit: BoxFit.fill,
                                                          ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    e.TituloAnunUser,
                                                    style: TextStyle(
                                                      color: textColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                  ],
                                )
                          : _anunciosFreelancer.isEmpty
                              ? SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                          0.747175 -
                                      60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.work_off,
                                        color: secTextColor,
                                        size: 70,
                                      ),
                                      Text(
                                        'Nenhum anúncio encontrado',
                                        style: TextStyle(
                                            fontSize: 16, color: secTextColor),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    Column(
                                      children: _anunciosFreelancer
                                          .map((e) => Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.30,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.90,
                                                    child: e.ImgAnunFr ==
                                                            'assets/images/testeImagemAnun.png'
                                                        ? Image.asset(
                                                            e.ImgAnunFr,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.file(
                                                            File(e.ImgAnunFr),
                                                            fit: BoxFit.fill,
                                                          ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    e.TituloAnunFr,
                                                    style: TextStyle(
                                                      color: textColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                    ),
                                  ],
                                ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

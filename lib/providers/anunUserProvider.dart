import 'dart:developer';

import 'package:bicos_app/model/anuncio_Usuario.dart';
import 'package:bicos_app/providers/clientProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cliente.dart';
import '../utils/app_routes.dart';
import '../utils/user_preferences.dart';

class AnunUserProvider with ChangeNotifier {
  late User user;

  Future<dynamic> addAnunUsuario(
    String titulo,
    String desc,
    String preco,
    String requisitos,
    String imgAnunUser,
    context,
  ) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var response = await Dio().post(
        'http://10.0.2.2:8000/api/addAnunUsuario',
        data: {
          'TituloAnunUser': titulo,
          'DescAnunUser': desc,
          'PrecoAnunUser':
              preco.replaceAll('.', '').replaceAll(',', '.').substring(3),
          'RequisitosAnunUser': requisitos,
          'ImgAnunUser': 'assets/images/testeImagemAnun.png',
          'StatusAnunUser': '1',
          'DataAnunUser': DateFormat('YYYY/MM/DD').format(DateTime.now()),
          'idUserAnunUser': UserPreferences.getUser().idUser,
          'NomeServAnunUser': 'Design de Logos',
        },
      );
      if (response.data['status'] == '200') {
        Fluttertoast.showToast(
          msg: response.data['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: response.data['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}

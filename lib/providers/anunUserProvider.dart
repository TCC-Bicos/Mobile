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

  List<AnuncioUsuario> _anunciosMyUser = [];
  List<AnuncioUsuario> getAnunciosMyUser() => _anunciosMyUser;

  Future<dynamic> addAnunUsuario(
    String titulo,
    String desc,
    String preco,
    String requisitos,
    String imgAnunUser,
    int idTipoServ,
    context,
  ) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var response = await Dio().post('http://10.0.2.2:8000/api/addAnunUsuario',
          data: {
            'TituloAnunUser': titulo,
            'DescAnunUser': desc,
            'PrecoAnunUser':
                preco.replaceAll('.', '').replaceAll(',', '.').substring(3),
            'RequisitosAnunUser': requisitos,
            'ImgAnunUser': imgAnunUser,
            'StatusAnunUser': '1',
            'DataAnunUser': DateFormat('yyyy-MM-dd').format(DateTime.now()),
            'idUserAnunUser': UserPreferences.getUser().idUser,
            'idTipoServAnunUser': idTipoServ,
          },
          options: Options(headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          }));
      if (response.data['status'] == '200') {
        Fluttertoast.showToast(
          msg: response.data['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.of(context).pop();
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
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> loadAnunMyUser(int id) async {
    try {
      _anunciosMyUser.clear();
      var response = await Dio()
          .get('http://10.0.2.2:8000/api/getAnunUsuarioByUsuario/$id');
      if (response.data['status'] == '200') {
        response.data['anuncios'].forEach(
          (k, e) {
            AnuncioUsuario anuncio = AnuncioUsuario(
              idAnunUser: e['idAnunUser'],
              TituloAnunUser: e['TituloAnunUser'],
              DescAnunUser: e['DescAnunUser'],
              PrecoAnunUser: e['PrecoAnunUser'],
              RequisitosAnunUser: e['RequisitosAnunUser'],
              ImgAnunUser: e['ImgAnunUser'],
              StatusAnunUser: e['StatusAnunUser'],
              DataAnunUser: e['DataAnunUser'],
              idUserAnunUser: e['idUserAnunUser'],
              idTipoServAnunUser: e['idTipoServAnunUser'],
            );
            if (anuncio.StatusAnunUser == '1') {
              if (_anunciosMyUser
                  .any((element) => element.idAnunUser == anuncio.idAnunUser)) {
                print('_');
              } else {
                _anunciosMyUser.add(anuncio);
              }
            }
          },
        );
      } else {
        print(response.data['message'].toString());
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

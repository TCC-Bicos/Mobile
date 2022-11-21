import 'dart:convert';

import 'package:bicos_app/model/servico.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/cliente.dart';
import '../utils/app_routes.dart';
import '../utils/user_preferences.dart';

class ServicosProvider with ChangeNotifier {
  late User user;

  List<TipoServico> _servicos = [];
  List<TipoServico> get getServicos => [..._servicos];

  Future<dynamic> getAllServicos() async {
    try {
      var response = await Dio().get('http://10.0.2.2:8000/api/getAllServicos');
      if (response.data['status'] == '200') {
        response.data['enderecos'].forEach(
          (k, e) {
            TipoServico servico = TipoServico(
              NomeServ: e['NomeServ'],
              CategoriaServ: e['CategoriaServ'],
            );
            _servicos.add(servico);
          },
        );
        notifyListeners();
      } else {
        print(response.data['message'].toString());
      }
    } catch (e) {
      print(e);
    }
  }
}

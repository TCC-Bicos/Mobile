import 'dart:convert';

import 'package:bicos_app/model/servico.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServicosProvider with ChangeNotifier {
  List<TipoServico> _servicos = [];
  List<TipoServico> getServicos() => _servicos;

  Future<void> loadServicos() async {
    try {
      _servicos.clear();
      var response = await Dio().get('http://10.0.2.2:8000/api/getAllServicos');
      if (response.data['status'] == '200') {
        response.data['servicos'].forEach(
          (e) {
            TipoServico servico = TipoServico(
              idTipoServ: e['idTipoServ'],
              NomeServ: e['NomeServ'],
              CategoriaServ: e['CategoriaServ'],
            );
            if (_servicos
                .any((element) => element.idTipoServ == servico.idTipoServ)) {
              print('_');
            } else {
              _servicos.add(servico);
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

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/cliente.dart';

class ClienteProvider with ChangeNotifier {
  List<Cliente> _clientes = [];
  List<Cliente> get getClientes => [..._clientes];

  Future<dynamic> loginCliente(String email, String senha) async {
    List<dynamic> list = [];
    Cliente? cliente;
    var response =
        await Dio().post('localhost:8000/api/loginUser/$email/$senha');

    if (response.data['status'] == '200') {
      cliente = Cliente(
        idCliente: response.data['user'][0]['idUser'],
        nomeCliente: response.data['user'][0]['nome'],
        cpfCliente: response.data['user'][0]['cpf'],
        emailCliente: response.data['user'][0]['email'],
        telefoneCliente: response.data['user'][0]['telefone'],
        nascimentoCliente: response.data['user'][0]['nascimento'],
        generoCliente: response.data['user'][0]['genero'],
        senhaCliente: response.data['user'][0]['senha'],
        imagemCliente: response.data['user'][0]['imagem'],
        statusCliente: response.data['user'][0]['statusCliente'],
      );
      list.add(true);
      list.add(cliente);
    } else {
      print(response.data['loginResult'].toString());
      list.add(false);
    }
    return list;
  }
}

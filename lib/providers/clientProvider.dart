import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/cliente.dart';
import '../utils/app_routes.dart';

class ClienteProvider with ChangeNotifier {
  List<Cliente> _clientes = [];
  List<Cliente> getClientes() => _clientes;

  Cliente user = Cliente(
    idCliente: 0,
    nomeCliente: 'nomeCliente',
    cpfCliente: 'cpfCliente',
    emailCliente: 'emailCliente',
    telefoneCliente: 'telefoneCliente',
    nascimentoCliente: 'nascimentoCliente',
    generoCliente: 'generoCliente',
    senhaCliente: 'senhaCliente',
    imagemCliente: 'imagemCliente',
    statusCliente: 'statusCliente',
  );

  Cliente getUser() => user;

  Future<dynamic> loginCliente(String email, String senha, context) async {
    var response =
        await Dio().post('localhost:8000/api/loginUser/$email/$senha');

    if (response.data['status'] == '200') {
      if (response.data['loginResult'] == '1') {
        Navigator.of(context).pushNamed(AppRoutes.navigationbar);
        user = Cliente(
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
      }
      print('certo');
    } else {
      print(response.data['loginResult'].toString());
    }
    return user;
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cliente.dart';
import '../utils/app_routes.dart';

class ClienteProvider with ChangeNotifier {
  List<User> _users = [];
  List<User> getUsers() => _users;

  User user = const User(
    idUser: 0,
    NomeUser: 'NomeUser',
    CPFUser: 'CPFUser',
    EmailUser: 'EmailUser',
    TelUser: 'TelUser',
    DataNascUser: 'DataNascUser',
    GeneroUser: 'GeneroUser',
    SenhaUser: 'SenhaUser',
    DescUser: 'DescUser',
    ImgUser: 'ImgUser',
    StatusUser: 'StatusUser',
  );

  User get getUser => user;

  Future<dynamic> loginUser(String email, String senha, context) async {
    try {
      var response =
          await Dio().get('http://10.0.2.2:8000/api/loginUser/$email/$senha');
      if (response.data['status'] == '200') {
        if (response.data['loginResult'] == '1') {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('emailValidation', email);

          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.navigationbar, (route) => false);
          user = User(
            idUser: response.data['User'][0]['idUser'],
            NomeUser: response.data['User'][0]['NomeUser'],
            CPFUser: response.data['User'][0]['CPFUser'],
            EmailUser: response.data['User'][0]['EmailUser'],
            TelUser: response.data['User'][0]['TelUser'],
            DataNascUser: response.data['User'][0]['DataNascUser'],
            GeneroUser: response.data['User'][0]['GeneroUser'],
            SenhaUser: response.data['User'][0]['SenhaUser'],
            DescUser: response.data['User'][0]['DescUser'],
            ImgUser: response.data['User'][0]['ImgUser'],
            StatusUser: response.data['User'][0]['StatusUser'],
          );
        }
      } else {
        print(response.data['loginResult'].toString());
      }
      return user;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deslogar() async {
    user = const User(
      idUser: 0,
      NomeUser: 'NomeUser',
      CPFUser: 'CPFUser',
      EmailUser: 'EmailUser',
      TelUser: 'TelUser',
      DataNascUser: 'DataNascUser',
      GeneroUser: 'GeneroUser',
      SenhaUser: 'SenhaUser',
      DescUser: 'DescUser',
      ImgUser: 'ImgUser',
      StatusUser: 'StatusUser',
    );
  }
}

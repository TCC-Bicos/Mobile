import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cliente.dart';
import '../utils/app_routes.dart';

class ClienteProvider with ChangeNotifier {
  List<User> _users = [];
  List<User> getUsers() => _users;

  User _user = const User(
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
    StatusUser: '1',
  );

  User get getUser => _user;

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
          _user = User(
            idUser: response.data['user']['idUser'] as int,
            NomeUser: response.data['user']['NomeUser'],
            CPFUser: response.data['user']['CPFUser'],
            EmailUser: response.data['user']['EmailUser'],
            TelUser: response.data['user']['TelUser'],
            DataNascUser: response.data['user']['DataNascUser'],
            GeneroUser: response.data['user']['GeneroUser'],
            SenhaUser: response.data['user']['SenhaUser'],
            DescUser: response.data['user']['DescUser'],
            ImgUser: response.data['user']['ImgUser'],
            StatusUser: response.data['user']['StatusUser'],
          );
          notifyListeners();
        }
      } else {
        print(response.data['loginResult'].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deslogar() async {
    _user = const User(
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
      StatusUser: '1',
    );
    notifyListeners();
  }

  Future<dynamic> updateUser(
      int idUser,
      String NomeUser,
      String CPFUser,
      String EmailUser,
      String TelUser,
      String DataNascUser,
      String GeneroUser,
      String SenhaUser,
      String DescUser,
      String ImgUser,
      int StatusUser,
      context) async {
    try {
      var response =
          await Dio().put('http://10.0.2.2:8000/api/updateUser/$idUser', data: {
        'idUser': idUser,
        'NomeUser': NomeUser,
        'CPFUser': CPFUser,
        'EmailUser': EmailUser,
        'TelUser': TelUser,
        'DataNascUser': DataNascUser,
        'GeneroUser': GeneroUser,
        'SenhaUser': SenhaUser,
        'DescUser': DescUser,
        'ImgUser': ImgUser,
        'StatusUser': StatusUser,
      });
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
      return _user;
    } catch (e) {
      print(e);
    }
  }
}
